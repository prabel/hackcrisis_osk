import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/domain/quiz/get_quiz_questions_use_case.dart';
import 'package:osk_flutter/model/quiz_question_model.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/no_connection_error_view.dart';
import 'package:osk_flutter/view/common/styled_circular_progress_indicator.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/quiz/bloc.dart';
import 'package:osk_flutter/view/quiz/quiz_answer_body.dart';
import 'package:osk_flutter/view/quiz/quiz_question_body.dart';
import 'package:osk_flutter/view/quiz/quiz_results_page.dart';
import 'package:osk_flutter/view/video/video_page.dart';

class QuizPage extends StatelessWidget {
  static MaterialPageRoute pageRoute({List<QuizQuestionModel> questions = const []}) =>
      MaterialPageRoute(builder: (BuildContext context) => QuizPage(questions));

  final List<QuizQuestionModel> questins;

  QuizPage(this.questins);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (context) =>
          QuizBloc(GetQuizQuestionsUseCase(context.repository<FirebaseRepository>()), questins)..add(LoadData()),
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      appBar: const IntroAppBar(
        backgroundColor: AppColors.turquoise,
        showBottomDash: false,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(AppImages.backgroundPng),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: _buildBody(context),
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (BuildContext context, QuizState state) {
        if (state is ShowResultsState) {
          Navigator.pushReplacement(context, QuizResultsPage.pageRoute(state.answerMap));
        }
        if (state is ShowVideo) {
          Navigator.push(context, VideoPage.pageRoute(youtubeUrl: state.videoUrl)).then((_) {
            BlocProvider.of<QuizBloc>(context).add(NextQuestion());
          });
        }
      },
      buildWhen: (_, newState) => !(newState is ShowResultsState) && !(newState is ShowVideo),
      builder: (BuildContext context, QuizState state) {
        if (state is ShowQuestionState) {
          return QuizQuestionBody(state);
        }

        if (state is ShowAnswerState) {
          return QuizAnswerBody(state);
        }

        if (state is ErrorState) {
          return NoConnectionErrorView(
            exception: state.exception,
            onRetryClick: () => BlocProvider.of<QuizBloc>(context).add(LoadData()),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Center(child: StyledCircularProgressIndicator()),
        );
      },
    );
  }
}
