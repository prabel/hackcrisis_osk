import 'package:flutter/material.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

enum AssistanceStatus {
  notNeeded,
  needAssistanceWithShopping,
  takeCareOfChild,
  myCompanyIssues,
  contractWork,
}

extension AssistanceStatusExtensions on AssistanceStatus {
  QuestionChoiceOption<AssistanceStatus> getQuestionChoiceOption() {
    switch (this) {
      case AssistanceStatus.notNeeded:
        return QuestionChoiceOption(this, "Nie, nie potrzebuję pomocy", [
          const Color(0Xff3AC168),
          const Color(0XFF84C749),
        ]);
      case AssistanceStatus.needAssistanceWithShopping:
        return QuestionChoiceOption(this, "Potrzebuję pomocy z zakupami", [
          const Color(0XffDBA513),
          const Color(0XFFDBA513),
        ]);
      case AssistanceStatus.takeCareOfChild:
        return QuestionChoiceOption(this, "Opiekuję się dzieckiem w wieku szkolnym ", [
          const Color(0XffDBA513),
          const Color(0XFFDBA513),
        ]);
      case AssistanceStatus.myCompanyIssues:
        return QuestionChoiceOption(this, "Prowadzę firmę i mam problem z wypłatą wynagrodzeń.", [
          const Color(0XffDBA513),
          const Color(0XFFDBA513),
        ]);
      case AssistanceStatus.contractWork:
        return QuestionChoiceOption(this, "Jestem zatrudniony na umowę o dzieło lub zlecenie.", [
          const Color(0XffDBA513),
          const Color(0XFFDBA513),
        ]);
      default:
        throw Exception("Invalid type");
    }
  }

  List<Color> getColors() => getQuestionChoiceOption().indicatorColors;

  String getDescription() => getQuestionChoiceOption().title;

  String getAdditionalInformation() {
    switch (this) {
      case AssistanceStatus.notNeeded:
        return "Pomoc dla osób pracujących na umowach o dzieło i zlecenie.";
      case AssistanceStatus.needAssistanceWithShopping:
        return "Pomoc dla osób pracujących na umowach o dzieło i zlecenie.";
      case AssistanceStatus.takeCareOfChild:
        return "Pomoc dla osób pracujących na umowach o dzieło i zlecenie.";
      case AssistanceStatus.myCompanyIssues:
        return "Pomoc dla osób pracujących na umowach o dzieło i zlecenie.";
      case AssistanceStatus.contractWork:
        return "Pomoc dla osób pracujących na umowach o dzieło i zlecenie.";
      default:
        throw Exception("Invalid type");
    }
  }
}
