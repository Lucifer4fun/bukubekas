import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart'; // Import paket collection untuk firstWhereOrNull
import 'package:uts/book_model.dart';
import 'package:uts/cart_item/cart_item.dart'; // Import CartItem

class CartProvider with ChangeNotifier {
  List<CartItem> _cart = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<CartItem> get cart => _cart;

  get totalPrice => _cart.fold(0, (total, item) => total + item.quantity * item.book.price);

  get items => _cart.map((item) => item.book).toList();

  CartProvider() {
    // Load cart from Firestore when the provider is initialized
    loadCartFromFirestore();
  }

  Future<void> loadCartFromFirestore() async {
    var snapshot = await _firestore.collection('cart').get();
    _cart = snapshot.docs.map((doc) => CartItem.fromMap(doc.data())).toList();
    notifyListeners();
  }

  Future<void> addToCart(BookModel book) async {
    var existingItem = _cart.firstWhereOrNull((item) => item.book.book_title == book.book_title);

    if (existingItem != null) {
      existingItem.quantity++;
      await _updateCartItemInFirestore(existingItem);
    } else {
      var newItem = CartItem(book, 1);
      _cart.add(newItem);
      await _addCartItemToFirestore(newItem);
    }

    notifyListeners();
  }

  Future<void> removeFromCart(BookModel book) async {
    _cart.removeWhere((item) => item.book == book);
    await _removeCartItemFromFirestore(book);
    notifyListeners();
  }

  int get cartCount => _cart.fold(0, (total, item) => total + item.quantity);

  Future<void> _addCartItemToFirestore(CartItem cartItem) async {
    await _firestore.collection('cart').add(cartItem.toMap());
  }

  Future<void> _updateCartItemInFirestore(CartItem cartItem) async {
    var doc = await _firestore
        .collection('cart')
        .where('book.bookTitle', isEqualTo: cartItem.book.book_title)
        .get();

    if (doc.docs.isNotEmpty) {
      await _firestore
          .collection('cart')
          .doc(doc.docs.first.id)
          .update(cartItem.toMap());
    }
  }

  Future<void> _removeCartItemFromFirestore(BookModel book) async {
    var doc = await _firestore
        .collection('cart')
        .where('book.bookTitle', isEqualTo: book.book_title)
        .get();

    if (doc.docs.isNotEmpty) {
      await _firestore.collection('cart').doc(doc.docs.first.id).delete();
    }
  }

  Future<void> clearCart() async {
    var snapshot = await _firestore.collection('cart').get();
    for (var doc in snapshot.docs) {
      await _firestore.collection('cart').doc(doc.id).delete();
    }
    _cart.clear();
    notifyListeners();
  }
}
