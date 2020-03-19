import 'package:flutter/material.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/intro/intro_step_one_page.dart';

class IntroVideoPage extends StatelessWidget {
  static MaterialPageRoute pageRoute() => MaterialPageRoute(
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
            PrimaryButton(
              title: "Rozpocznij",
              onClick: () {
                Navigator.pushReplacement(context, IntroStepOnePage.pageRoute());
              },
            ),
            const SizedBox(height: 70),
          ],
        ));
  }
}
