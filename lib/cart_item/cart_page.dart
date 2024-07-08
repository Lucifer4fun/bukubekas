import 'package:flutter/material.dart';
import 'cart_item.dart';
import 'package:uts/data.dart';
import 'package:uts/detail.dart';

class CartPage extends StatelessWidget {
  final List<CartItem> cart;

  CartPage({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KERANJANG'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cart[index].book.title),
            subtitle: Text('Jumlah: ${cart[index].quantity}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                _showConfirmationDialog(context, cart[index]);
              },
            ),
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, CartItem cartItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus dari Keranjang'),
          content: Text(
              'Apakah Anda yakin ingin menghapus ${cartItem.book.title} dari keranjang?'),
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
                // Panggil fungsi removeFromCart dari provider atau implementasikan penghapusan item di sini
                // Contoh:
                // Provider.of<CartProvider>(context, listen: false).removeFromCart(cartItem.book);
                // atau
                // _removeFromCartLocally(cartItem);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Contoh fungsi untuk menghapus item dari keranjang secara lokal (tanpa menggunakan provider)
  // void _removeFromCartLocally(CartItem cartItem) {
  //   cart.remove(cartItem);
  // }
}
