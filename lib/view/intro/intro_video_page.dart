import 'package:flutter/material.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/intro/intro_step_one_page.dart';

class IntroVideoPage extends StatelessWidget {
  static MaterialPageRoute pageRoute = MaterialPageRoute(
    builder: (BuildContext context) => IntroVideoPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: const IntroAppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Spacer(),
            FlatButton(
              child: Text("Rozpocznij"),
              onPressed: () {
                Navigator.pushReplacement(context, IntroStepOnePage.pageRoute());
              },
            )
          ],
        ));
  }
}
