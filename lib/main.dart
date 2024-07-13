import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:uts/cart_item/cart_provider.dart';
import 'package:uts/cart_item/cart_page.dart';
import 'package:uts/data.dart';
import 'package:uts/detail.dart';
import 'package:uts/admin/auth_service.dart';
import 'package:uts/firebase_options.dart';
import 'package:uts/home.dart';
import 'package:uts/splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Toko Buku Bekas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(
          title: '',
        ),
        routes: {
          '/cart': (context) => CartPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Buku Bekas'),
      ),
      body: Center(
        child: Text('Selamat datang di Toko Buku Bekas!'),
      ),
    );
  }
}
