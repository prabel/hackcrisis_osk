import 'package:flutter/material.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/surveys/elements/one_choice_qustion_widget.dart';

const List<QuestionChoiceOption> healthStatusOptions = [
  QuestionChoiceOption("1", "Jestem, zdrowy, nie chorowałem", indicatorColor: Colors.green),
  QuestionChoiceOption("2", "Wyzdrowiałem", indicatorColor: Colors.green),
  QuestionChoiceOption("3", "Obawiam się, że ja choruję", indicatorColor: Colors.red),
  QuestionChoiceOption("4", "Mam pewność, że choruję", indicatorColor: Colors.red),
  QuestionChoiceOption("5", "Ktoś w mojej okolicy choruje", indicatorColor: Colors.yellow),
  QuestionChoiceOption("6", "Mam inna chorobę przeklekła", indicatorColor: Colors.yellow),
];

class HealthStatusSurveyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IntroAppBar(appBarTheme: IntroAppBarTheme.dark),
      body: Column(
        children: <Widget>[
          const Text("Czy chorujesz na koronawirusa?"),
          const OneChoiceQuestionWidget(
            options: healthStatusOptions,
          ),
          const Spacer(),
          Center(
            child: FlatButton(child: Text("Dalej"), onPressed: () {}),
          )
        ],
      ),
    );
  }
}
