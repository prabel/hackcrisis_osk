import 'package:flutter/material.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

enum HealthStatus {
  healthy,
  recovered,
  probablySick,
  closePersonSick,
  personInAreaIsSick,
  otherDisease,
}

extension HealthStatusExtensions on HealthStatus {
  QuestionChoiceOption getQuestionChoiceOption() {
    switch (this) {
      case HealthStatus.healthy:
        return QuestionChoiceOption("1", "Jestem, zdrowy", [
          const Color(0Xff3AC168),
          const Color(0XFF84C749),
        ]);
      case HealthStatus.recovered:
        return QuestionChoiceOption("2", "Wyzdrowiałem", [
          const Color(0Xff3AC168),
          const Color(0XFF84C749),
        ]);
      case HealthStatus.probablySick:
        return QuestionChoiceOption("3", "Obawiam się, że ja choruję", [
          const Color(0XffD14457),
          const Color(0XFFD14486),
        ]);
      case HealthStatus.closePersonSick:
        return QuestionChoiceOption("4", "Bliska mi osoba choruje", [
          const Color(0XffD14457),
          const Color(0XFFD14486),
        ]);
      case HealthStatus.personInAreaIsSick:
        return QuestionChoiceOption("5", "Ktoś w mojej okolicy choruje", [
          const Color(0XffDBA513),
          const Color(0XFFDBA513),
        ]);
      case HealthStatus.otherDisease:
        return QuestionChoiceOption("5", "Ktoś w mojej okolicy choruje", [
          const Color(0XffDBA513),
          const Color(0XFFDBA513),
        ]);
      default:
        throw Exception("Invalid type");
    }
  }

  List<Color> getColors() => getQuestionChoiceOption().indicatorColors;

  String getDescription() => getQuestionChoiceOption().title;
}
