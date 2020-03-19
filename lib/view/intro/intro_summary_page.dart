import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/main/main_navigation_page.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

class IntroSummaryPage extends StatelessWidget {
  static MaterialPageRoute pageRoute(QuestionChoiceOption selectedChoice) => MaterialPageRoute(
        builder: (BuildContext context) => IntroSummaryPage(
          selectedHealthChoice: selectedChoice,
        ),
      );

  final QuestionChoiceOption selectedHealthChoice;

  const IntroSummaryPage({Key key, this.selectedHealthChoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: selectedHealthChoice.indicatorColors,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Image.asset(AppImages.backgroundPng),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const IntroAppBar(
            appBarTheme: IntroAppBarTheme.light,
          ),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Dziękujemy.\nCieszymy się,\nże jesteś zdrowa!",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 34),
                    Text(
                      "Aplikacja pozwoli Ci zadbać,\nżeby tak pozostało.",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 46),
                    PrimaryButton(
                      title: "Dalej",
                      onClick: () {
                        Navigator.pushReplacement(context, MainNavigationPage.pageRoute);
                      },
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getCheckmarkItem(String text) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.check,
          color: AppColors.primaryBlue,
        ),
        const SizedBox(width: 24),
        Text(
          text,
          style: TextStyle(
            fontSize: 17,
            color: AppColors.darkGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
