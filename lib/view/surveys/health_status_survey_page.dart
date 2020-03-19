import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/values/health_statuses.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/intro/intro_summary_page.dart';
import 'package:osk_flutter/view/surveys/elements/one_choice_qustion_widget.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

class HealthStatusSurveyPage extends StatefulWidget {
  static List<QuestionChoiceOption> healthStatusOptions = [
    HealthStatus.healthy.getQuestionChoiceOption(),
    HealthStatus.recovered.getQuestionChoiceOption(),
    HealthStatus.probablySick.getQuestionChoiceOption(),
    HealthStatus.closePersonSick.getQuestionChoiceOption(),
    HealthStatus.personInAreaIsSick.getQuestionChoiceOption(),
    HealthStatus.otherDisease.getQuestionChoiceOption(),
  ];

  static MaterialPageRoute pageRoute() => MaterialPageRoute(
        builder: (BuildContext context) => HealthStatusSurveyPage(),
      );

  @override
  _HealthStatusSurveyPageState createState() => _HealthStatusSurveyPageState();
}

class _HealthStatusSurveyPageState extends State<HealthStatusSurveyPage> {
  QuestionChoiceOption selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IntroAppBar(),
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(AppImages.backgroundPng),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  "Czy chorujesz\nna koronawirusa?",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                OneChoiceQuestionWidget(
                  options: HealthStatusSurveyPage.healthStatusOptions,
                  onChoiceSelect: (choice) {
                    selectedChoice = choice;
                  },
                ),
                const Spacer(),
                PrimaryButton(
                  title: "Dalej",
                  onClick: () {
                    if (selectedChoice != null) {
                      Navigator.push(context, IntroSummaryPage.pageRoute(selectedChoice));
                    }
                  },
                ),
                const SizedBox(height: 70),
              ],
            ),
          )
        ],
      ),
    );
  }
}
