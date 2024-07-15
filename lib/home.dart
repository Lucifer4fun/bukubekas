import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts/book_model.dart';
import 'package:uts/cart_item/cart_provider.dart';
import 'package:uts/detail.dart';
import 'package:uts/ui/main_view.dart';
import 'package:uts/ui/screens/login_screen.dart';
import 'package:uts/ui/screens/screen_page.dart';
import "package:uts/ui/screens/sing_up_screen.dart";
import 'checkout.dart';
import 'package:uts/searching.dart';
import 'data.dart';
import 'package:uts/upload_buku.dart';
import "package:uts/cart_item/cart_item.dart";
import "package:uts/cart_item/cart_page.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CartItem> cart = [];

  void addToCart(BookModel book) {
    setState(() {
      // cart.add(CartItem(book, 1));
      Provider.of<CartProvider>(context, listen: false).addToCart(book);
    });
  }

  void removeFromCart(BookModel book) {
    setState(() {
      cart.removeWhere((item) => item.book == book);
    });
  }

  void viewCart() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartPage()));
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: .5,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: Text('Toko Buku Bekas'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.file_upload),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: viewCart,
        ),
      ],
    );

    createTile(BookModel book) => Hero(
          tag: book.book_title ?? '',
          child: Material(
            elevation: 15.0,
            shadowColor: Colors.purple.shade900,
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Detail(book)));
              },
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(book.book_poster_url ?? ''),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 7.5,
                  ),
                  IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      addToCart(book);
                    },
                  ),
                ],
              ),
            ),
          ),
        );

    final grid = CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid.count(
            childAspectRatio: 2 / 3,
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: main_book_list.map((book) => createTile(book)).toList(),
          ),
        )
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Toko Buku Bekas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.purple.shade900,
              ),
            ),
            ListTile(
              title: Text('Kembali ke Login'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: grid,
    );
  }
}
