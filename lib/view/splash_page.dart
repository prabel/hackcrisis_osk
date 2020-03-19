import 'package:flutter/material.dart';
import 'package:osk_flutter/view/intro/intro_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text("Przejdz to intro"),
          onPressed: () => Navigator.pushReplacement(context, IntroPage.pageRoute()),
        ),
      ),
    );
  }
}
