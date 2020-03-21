import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/model/user_model.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/values/assistance_statuses.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/surveys/elements/multiple_choice_qustion_widget.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

const List<QuestionChoiceOption> healthStatusOptions = [
  QuestionChoiceOption("1", "Nie, nie potrzebuję", [Colors.green]),
  QuestionChoiceOption("2", "Potrzebuję pomocy z zakupami", [Colors.yellow]),
  QuestionChoiceOption("3", "Prebywam za granica", [Colors.yellow]),
  QuestionChoiceOption("4", "Trudna sytuacja życiowa", [Colors.yellow]),
];

class AssistanceSurveyPage extends StatefulWidget {
  static List<QuestionChoiceOption<AssistanceStatus>> assistanceStatusOptions = [
    AssistanceStatus.notNeeded.getQuestionChoiceOption(),
    AssistanceStatus.needAssistanceWithShopping.getQuestionChoiceOption(),
    AssistanceStatus.takeCareOfChild.getQuestionChoiceOption(),
    AssistanceStatus.myCompanyIssues.getQuestionChoiceOption(),
    AssistanceStatus.contractWork.getQuestionChoiceOption(),
  ];

  static MaterialPageRoute pageRoute(List<AssistanceStatus> currentAssistanceStatus) => MaterialPageRoute(
        builder: (BuildContext context) => AssistanceSurveyPage(currentAssistanceStatus),
      );

  final List<AssistanceStatus> currentAssistanceStatus;

  const AssistanceSurveyPage(this.currentAssistanceStatus, {Key key}) : super(key: key);

  @override
  _AssistanceSurveyPageState createState() => _AssistanceSurveyPageState();
}

class _AssistanceSurveyPageState extends State<AssistanceSurveyPage> {
  List<QuestionChoiceOption<AssistanceStatus>> selectedChoices = [];

  @override
  void initState() {
    super.initState();
    selectedChoices = widget.currentAssistanceStatus.map((item) => item.getQuestionChoiceOption()).toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IntroAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(AppImages.backgroundPng),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        const Text(
                          "Czy potrzebujesz\npomocy?",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 22),
                        const Text(
                          "Wybierz dowolną liczbę opcji.",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 28),
                        MultipleChoiceQuestionWidget<AssistanceStatus>(
                          options: AssistanceSurveyPage.assistanceStatusOptions,
                          onChoiceSelect: (choices) {
                            selectedChoices = choices;
                          },
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),
                PrimaryButton(
                  title: "Dalej",
                  onClick: () {
                    _saveSelectedChoice(context);
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _saveSelectedChoice(BuildContext context) async {
    if (selectedChoices.isNotEmpty) {
      final UserRepository userRepository = RepositoryProvider.of<UserRepository>(context);
      final UserModel currentUserModel = await userRepository.getCurrentUserModel();
      await userRepository.createOrUpdateUser(
          currentUserModel.copyWith(assistanceStatusIds: selectedChoices.map((it) => it.option.index).toList()));

      Navigator.pop(context, selectedChoices.map((item) => item.option).toList());
    }
  }
}
