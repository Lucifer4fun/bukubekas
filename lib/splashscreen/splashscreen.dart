import 'package:flutter/material.dart';
import 'package:uts/ui/screens/login_screen.dart';
import 'package:uts/ui/screens/screen_page.dart'; // Ensure the path is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required String title});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen();
  }

  void _navigateToLoginScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
