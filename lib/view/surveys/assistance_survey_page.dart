import 'package:flutter/material.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/surveys/elements/one_choice_qustion_widget.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

const List<QuestionChoiceOption> healthStatusOptions = [
  QuestionChoiceOption("1", "Nie, nie potrzebuję", [Colors.green]),
  QuestionChoiceOption("2", "Potrzebuję pomocy z zakupami", [Colors.yellow]),
  QuestionChoiceOption("3", "Prebywam za granica", [Colors.yellow]),
  QuestionChoiceOption("4", "Trudna sytuacja życiowa", [Colors.yellow]),
];

class AssistanceSurveyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IntroAppBar(appBarTheme: IntroAppBarTheme.dark),
      body: Column(
        children: <Widget>[
          const Text("Czy potrzebujesz pomocy?"),
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
