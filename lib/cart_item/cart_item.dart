import 'package:uts/book_model.dart';

class CartItem {
  BookModel book;
  int quantity;

  CartItem(this.book, this.quantity);

  Map<String, dynamic> toMap() {
    return {
      'book': book.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      BookModel.fromMap(map['book']),
      map['quantity'],
    );
  }
}
