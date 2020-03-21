import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osk_flutter/model/user_model.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/intro/intro_step_two_page.dart';

class IntroStepOnePage extends StatelessWidget {
  static MaterialPageRoute pageRoute() => MaterialPageRoute(builder: (BuildContext context) => IntroStepOnePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IntroAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SvgPicture.asset(AppImages.background),
          const _IntroStepOneBody(),
        ],
      ),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 42),
                  Text(
                    "Poznajmy się",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Jak masz na imię?",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 36),
                  TextFormField(
                    controller: _nameTextController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: AppColors.primaryBlue),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: "Imię",
                      hintText: "Wpisz swoje imię",
                    ),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Podaj swoje imię aby kontynuować";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 215,
                  child: PrimaryButton(
                    title: "Dalej",
                    onClick: () => _proceedToNextScreen(context),
                  ),
                ),
                const Spacer(),
                Text(
                  "1 ",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "z 2",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _proceedToNextScreen(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      UserModel userModel = UserModel(name: _nameTextController.text);
      Navigator.pushReplacement(context, IntroStepTwoPage.pageRoute(userModel));
    } else {
      setState(() {
        _shouldAutoValidate = true;
      });
    }
  }
}
