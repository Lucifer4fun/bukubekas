import "package:flutter/material.dart";
import "package:uts/ui/screens/login_screen.dart";
import "package:uts/ui/screens/sing_up_screen.dart";

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void tooglescreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

    if (showLoginPage) {
      return LoginScreen(
        showRegisterPage: tooglescreen,
        controller: controller,
      );
    } else {
      return SingUpScreen(showLoginPage: tooglescreen);
    }
  }
}
