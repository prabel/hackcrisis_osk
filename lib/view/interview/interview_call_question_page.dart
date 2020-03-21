import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/interview/interview_quarantine_question_page.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/main/main_navigation_page.dart';

class InterviewCallQuestionPage extends StatelessWidget {
  static MaterialPageRoute pageRoute() =>
      MaterialPageRoute(builder: (BuildContext context) => InterviewCallQuestionPage());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: AppColors.redBase,
        appBar: const IntroAppBar(
          backgroundColor: Colors.transparent,
          appBarTheme: IntroAppBarTheme.light,
        ),
        body: Stack(
          children: <Widget>[
            Image.asset(AppImages.backgroundPng),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Text(
                    "Czy zadzwoniłeś\njuż do stacji\nepidemiologicznej?",
                    style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold, height: 45 / 30),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    "Pamiętaj, jest to konieczne by powiadomić odpowiendi służby o swoim stanie zdrowia.",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 35 / 20,
                    ),
                  ),
                  Spacer(),
                  PrimaryButton(
                    title: "Tak",
                    onClick: () => Navigator.push(context, InterviewQuarantineQuestionPage.pageRoute()),
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    title: "Jeszcze nie",
                    onClick: () => _handleClickOnNext(context),
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async => false,
    );
  }

  Future _handleClickOnNext(BuildContext context) async {
    Navigator.pushAndRemoveUntil(context, MainNavigationPage.pageRoute(), (_) => false);
  }
}
