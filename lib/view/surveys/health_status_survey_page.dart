import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/model/user_model.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/values/health_statuses.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/interview/interview_page.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/intro/intro_summary_page.dart';
import 'package:osk_flutter/view/surveys/elements/one_choice_qustion_widget.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';
import 'package:osk_flutter/view/video/video_page.dart';

class HealthStatusSurveyPage extends StatefulWidget {
  static List<QuestionChoiceOption<HealthStatus>> healthStatusOptions = [
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
  QuestionChoiceOption<HealthStatus> selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IntroAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(AppImages.backgroundPng),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
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
                  OneChoiceQuestionWidget<HealthStatus>(
                    options: HealthStatusSurveyPage.healthStatusOptions,
                    onChoiceSelect: (choice) {
                      selectedChoice = choice;
                    },
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    title: "Dalej",
                    onClick: () {
                      _saveSelectedChoice(context);
                    },
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveSelectedChoice(BuildContext context) async {
    if (selectedChoice != null) {
      final UserRepository userRepository = RepositoryProvider.of<UserRepository>(context);
      final UserModel currentUserModel = await userRepository.getCurrentUserModel();

      if (selectedChoice.option == HealthStatus.healthy || selectedChoice.option == HealthStatus.recovered) {
        await userRepository.createOrUpdateUser(currentUserModel.copyWith(
          healthStatusId: selectedChoice.option.index,
          presumablySick: false,
          quarantineStartDate: null,
        ));
        Navigator.pushReplacement(context, IntroSummaryPage.pageRoute(selectedChoice));
      } else {
        await userRepository.createOrUpdateUser(currentUserModel.copyWith(healthStatusId: selectedChoice.option.index));

        try {
          final videoUrl = await RepositoryProvider.of<FirebaseRepository>(context).getInterviewVideoUrl();
          Navigator.pushReplacement(
              context, VideoPage.pageRoute(youtubeUrl: videoUrl, nextPageRoute: InterviewPage.pageRoute()));
        } catch (e) {
          print("Error occurs when loading video url $e");
        }
      }
    }
  }
}
