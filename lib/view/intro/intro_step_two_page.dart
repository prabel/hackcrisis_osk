import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/model/user_model.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/surveys/health_status_survey_page.dart';

class IntroStepTwoPage extends StatelessWidget {
  static MaterialPageRoute pageRoute(UserModel userModel) =>
      MaterialPageRoute(builder: (BuildContext context) => IntroStepTwoPage(userModel));

  final UserModel userModel;

  const IntroStepTwoPage(this.userModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IntroAppBar(),
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(AppImages.background),
          _IntroStepTwoBody(userModel),
        ],
      ),
    );
  }
}

class _IntroStepTwoBody extends StatefulWidget {
  final UserModel userModel;

  _IntroStepTwoBody(this.userModel);

  @override
  _IntroStepTwoBodyState createState() => _IntroStepTwoBodyState();
}

class _IntroStepTwoBodyState extends State<_IntroStepTwoBody> {
  final TextEditingController _ageTextController = TextEditingController();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _ageTextController,
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                BackButton(
                  color: AppColors.primaryBlue,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                SizedBox(
                  width: 215,
                  child: PrimaryButton(
                    title: "Dalej",
                    onClick: () {
                      if (_formKey.currentState.validate()) {
                        _proceedToNextScreen(context);
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future _proceedToNextScreen(BuildContext context) async {
    await RepositoryProvider.of<UserRepository>(context)
        .createOrUpdateUser(widget.userModel.copyWith(age: _ageTextController.text));
    Navigator.pushAndRemoveUntil(context, HealthStatusSurveyPage.pageRoute(), (_) => false);
  }
}
