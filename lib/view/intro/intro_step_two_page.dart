import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/surveys/health_status_survey_page.dart';

class IntroStepTwoPage extends StatelessWidget {
  static MaterialPageRoute pageRoute() => MaterialPageRoute(builder: (BuildContext context) => IntroStepTwoPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IntroAppBar(),
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(AppImages.background),
          const _IntroStepTwoBody(),
        ],
      ),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              "Ile masz lat?",
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: AppColors.primaryBlue),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              validator: (text) {
                if (text.isEmpty) {
                  return "Podaj swój wiek";
                }
                return null;
              },
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                BackButton(
                  color: AppColors.primaryBlue,
                ),
                Spacer(),
                SizedBox(
                  width: 215,
                  child: PrimaryButton(
                    title: "Dalej",
                    onClick: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.push(context, HealthStatusSurveyPage.pageRoute());
                      } else {
                        setState(() {
                          _shouldAutoValidate = true;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
