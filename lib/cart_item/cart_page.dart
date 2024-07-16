import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uts/cart_item/cart_item.dart';
import 'package:uts/cart_item/cart_provider.dart';
import 'package:uts/cart_item/cart_provider.dart';
import 'package:uts/success/buy_success.dart';
import 'package:uts/transaksi.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KERANJANG'),
        actions: [
          IconButton(
            icon: Icon(Icons.receipt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransactionPage()),
              );
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.cart.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cart[index];
                    return ListTile(
                      leading: Image.network(
                        cartItem.book.book_poster_url ?? '',
                        width: 50,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      title: Text(cartItem.book.book_title ?? ''),
                      subtitle: Text('Jumlah: ${cartItem.quantity}'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          _showConfirmationDialog(
                              context, cartItem, cartProvider);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showPurchaseConfirmationDialog(context, cartProvider);
                  },
                  child: Text('Beli'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, CartItem cartItem, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus dari Keranjang'),
          content: Text(
              'Apakah Anda yakin ingin menghapus ${cartItem.book.book_title} dari keranjang?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                cartProvider.removeFromCart(cartItem.book);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPurchaseConfirmationDialog(
      BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembelian'),
          content:
              Text('Apakah Anda yakin ingin membeli semua item di keranjang?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Beli'),
              onPressed: () async {
                await _purchaseItems(context, cartProvider);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SuccessPage1(
                          title: '',
                        )));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _purchaseItems(
      BuildContext context, CartProvider cartProvider) async {
    try {
      // Simpan data transaksi ke Firestore
      final transactions = cartProvider.cart.map((cartItem) {
        return {
          'book_title': cartItem.book.book_title,
          'quantity': cartItem.quantity,
          'timestamp': Timestamp.now(),
        };
      }).toList();

      final batch = FirebaseFirestore.instance.batch();
      final transactionRef =
          FirebaseFirestore.instance.collection('transactions');

      for (var transaction in transactions) {
        batch.set(transactionRef.doc(), transaction);
      }

      await batch.commit();

      // Bersihkan keranjang
      await cartProvider.clearCart();
    } catch (e) {}

    Navigator.of(context).pop();
  }
}
