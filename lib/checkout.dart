import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uts/success/buy_success.dart';
import 'package:uts/home.dart';
import 'package:uts/success/upload_success.dart';
import 'chatdetail/chatdetailpage.dart';
import 'popup.dart'; // Assuming you have the PopupForm widget defined in popup.dart
import 'data.dart';
import 'rating_bar.dart';

String? _paymentMethod;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Buku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Detail(
        Book('CorelDraw untuk Tingkat Pemula Sampai Mahir',
            'Jubilee Enterprise', 'Rp 50.000', 'assets/corel.jpg', 3.5, 123),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  final Book book;

  Detail(this.book);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: .5,
      title: Text('Toko Buku'),
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
            tag: book.title!,
            child: Material(
              elevation: 15.0,
              shadowColor: Colors.purple.shade900,
              child: Image(
                image: AssetImage(book.image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            '${book.pages} halaman',
            style: TextStyle(color: Colors.white30, fontSize: 12),
          ),
        ),
      ],
    );

    final topRight = Container(
      decoration: BoxDecoration(
        color: Colors.grey[800], // Warna latar belakang kontainer
        borderRadius: BorderRadius.circular(
            10), // Membuat sudut kontainer menjadi lebih melengkung
      ),
      padding: EdgeInsets.all(16), // Padding di sekitar isi kontainer
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              book.title!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
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
                book.price!,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              RatingBar(rating: book.rating!, color: Colors.white),
            ],
          ),
          SizedBox(
              height:
                  16), // Menambahkan jarak antara elemen-elemen dalam kontainer
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nama',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
              height:
                  8), // Menambahkan jarak antara elemen-elemen dalam kontainer
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Alamat',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(color: Colors.white),
            onSaved: (value) {},
          ),
          SizedBox(
              height:
                  8), // Menambahkan jarak antara elemen-elemen dalam kontainer
          Row(
            children: <Widget>[
              Radio(
                value: 'COD',
                groupValue: _paymentMethod,
                onChanged: (String? value) {},
              ),
              Text(
                'COD',
                style: TextStyle(color: Colors.white),
              ),
              Radio(
                value: 'Pengiriman',
                groupValue: _paymentMethod,
                onChanged: (String? value) {},
              ),
              Text(
                'Pengiriman',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),

          SizedBox(
              height:
                  8), // Menambahkan jarak antara elemen-elemen dalam kontainer
          MaterialButton(
            onPressed: () {
              // Navigasi ke layar atau rute tertentu saat tombol ditekan
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SuccessPage1(
                          title: '',
                        )),
              );
            },
            minWidth: 160.0,
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('BELI', style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );

    final topContent = Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 2, child: topLeft),
          Expanded(flex: 3, child: topRight),
        ],
      ),
    );

    final bottomContent = SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
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
          // Form pembayaran
        ],
      ),
    );
  }
}
