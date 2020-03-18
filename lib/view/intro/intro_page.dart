import 'package:flutter/material.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/intro/intro_video_page.dart';

class IntroPage extends StatelessWidget {
  static MaterialPageRoute pageRoute = MaterialPageRoute(
    builder: (BuildContext context) => IntroPage(),
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
              Navigator.pushReplacement(context, IntroVideoPage.pageRoute);
            },
          )
        ],
      ),
    );
  }
}
