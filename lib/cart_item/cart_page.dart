import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'cart_item.dart';
import 'cart_provider.dart'; // Import CartProvider
import 'package:uts/data.dart';
import 'package:uts/detail.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KERANJANG'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return ListView.builder(
            itemCount: cartProvider.cart.length,
            itemBuilder: (context, index) {
              final cartItem = cartProvider.cart[index];
              return ListTile(
                title: Text(cartItem.book.book_title ?? ''),
                subtitle: Text('Jumlah: ${cartItem.quantity}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    _showConfirmationDialog(context, cartItem, cartProvider);
                  },
                ),
              );
            },
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
}
