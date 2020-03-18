import 'package:flutter/material.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/main/main_navigation_page.dart';

class IntroStepTwoPage extends StatelessWidget {
  static MaterialPageRoute pageRoute = MaterialPageRoute(builder: (BuildContext context) => IntroStepTwoPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: const IntroAppBar(),
    );
  }
}

class _IntroStepTwoBody extends StatefulWidget {
  const _IntroStepTwoBody();

  @override
  _IntroStepTwoBodyState createState() => _IntroStepTwoBodyState();
}

class _IntroStepTwoBodyState extends State<_IntroStepTwoBody> {
  final TextEditingController _nameTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _shouldAutoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _shouldAutoValidate,
      child: Column(
        children: <Widget>[
          Text("Poznajmy się 2/2"),
          Spacer(),
          Text("Podaj rok twojego urodzenia"),
          TextFormField(
              controller: _nameTextController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
              )),
          const SizedBox(height: 32),
          Center(
            child: FlatButton(
              child: Text(
                "Dalej",
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.of(context)
                    ..popUntil((_) => false)
                    ..push(MainNavigationPage.pageRoute);
                } else {
                  setState(() {
                    _shouldAutoValidate = true;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
