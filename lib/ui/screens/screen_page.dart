import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uts/home.dart';
import 'package:uts/ui/screens/auth_screen.dart';
import 'package:uts/ui/screens/home_screen.dart';
import 'package:uts/ui/screens/login_screen.dart';
import 'package:uts/ui/screens/sing_up_screen.dart';
import 'package:uts/upload_buku.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
