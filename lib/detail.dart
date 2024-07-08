import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts/book_model.dart';
import 'package:uts/cart_item/cart_item.dart';
import 'package:uts/data.dart';
import 'package:uts/cart_item/cart_provider.dart'; // Import CartProvider
import 'package:uts/cart_item/cart_page.dart'; // Sesuaikan dengan lokasi CartPage
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts/checkout.dart';
import 'chatdetail/chatdetailpage.dart';
import 'popup.dart';

class Detail extends StatelessWidget {
  final BookModel book;

  Detail(this.book);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: .5,
      title: Text('Toko Buku Bekas'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
    );

    final topLeft = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: book.book_title ?? "-",
            child: Material(
              elevation: 15.0,
              shadowColor: Colors.purple.shade900,
              child: Image(
                image: NetworkImage(book.book_poster_url!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );

    final topRight = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            book.book_title!,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
          child: Text(
            'oleh ${book.writer}',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
        Row(
          children: <Widget>[
            Text(
              book.category.toString(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            // RatingBar(rating: book.rating!, color: Colors.white),
          ],
        ),
        SizedBox(height: 32.0),
        MaterialButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text('Pembelian Buku Bekas'),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatDetailPage()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.phone),
                            const SizedBox(width: 10),
                            const Text('Hubungi Penjual'),
                          ],
                        ),
                      ),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Checkout(book),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.shopping_bag),
                          const SizedBox(width: 10),
                          const Text('Beli Sekarang'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
          minWidth: 160.0,
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('BELI', style: TextStyle(fontSize: 13)),
        ),
        MaterialButton(
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false).addToCart(book);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('${book.book_title} ditambahkan ke keranjang')),
            );
          },
          minWidth: 160.0,
          color: Colors.green,
          textColor: Colors.white,
          child: Text('Tambah ke Keranjang', style: TextStyle(fontSize: 13)),
        ),
        SizedBox(height: 16), // Jarak antara tombol dan deskripsi
      ],
    );

    final topContent = Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 2, child: topLeft),
              Expanded(flex: 3, child: topRight),
            ],
          ),
        ],
      ),
    );

    final bottomContent = SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        minWidth: double.infinity,
        color: Colors.orange,
        textColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text('Lihat Keranjang', style: TextStyle(fontSize: 16)),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  topContent,
                  bottomContent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
