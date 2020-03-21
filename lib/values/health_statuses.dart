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
  QuestionChoiceOption<HealthStatus> getQuestionChoiceOption() {
    switch (this) {
      case HealthStatus.healthy:
        return QuestionChoiceOption(this, "Jestem zdrowy", [
          const Color(0Xff3AC168),
          const Color(0XFF84C749),
        ]);
      case HealthStatus.recovered:
        return QuestionChoiceOption(this, "Wyzdrowiałem", [
          const Color(0Xff3AC168),
          const Color(0XFF84C749),
        ]);
      case HealthStatus.probablySick:
        return QuestionChoiceOption(this, "Obawiam się, że ja choruję", [
          const Color(0XffD14457),
          const Color(0XFFD14486),
        ]);
      case HealthStatus.closePersonSick:
        return QuestionChoiceOption(this, "Bliska mi osoba choruje", [
          const Color(0XffD14457),
          const Color(0XFFD14486),
        ]);
      case HealthStatus.personInAreaIsSick:
        return QuestionChoiceOption(this, "Ktoś w mojej okolicy choruje", [
          const Color(0XffDBA513),
          const Color(0XFFDBA513),
        ]);
      case HealthStatus.otherDisease:
        return QuestionChoiceOption(this, "Mam inną chorobę", [
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
