import 'package:flutter/material.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/intro/intro_step_two_page.dart';

class IntroStepOnePage extends StatelessWidget {
  static MaterialPageRoute pageRoute = MaterialPageRoute(builder: (BuildContext context) => IntroStepOnePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: const IntroAppBar(),
      body: const _IntroStepOneBody(),
    );
  }
}

class _IntroStepOneBody extends StatefulWidget {
  const _IntroStepOneBody();

  @override
  _IntroStepOneBodyState createState() => _IntroStepOneBodyState();
}

class _IntroStepOneBodyState extends State<_IntroStepOneBody> {
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
          Text("Poznajmy się"),
          Spacer(),
          Text("Jak masz na imię?"),
          TextFormField(
              controller: _nameTextController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Imię",
              )),
          const SizedBox(height: 32),
          Center(
            child: FlatButton(
              child: Text(
                "Dalej",
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.push(context, IntroStepTwoPage.pageRoute);
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
