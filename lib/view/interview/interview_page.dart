import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/domain/interview/get_interview_questions_use_case.dart';
import 'package:osk_flutter/domain/user/get_user_use_case.dart';
import 'package:osk_flutter/domain/user/update_user_use_case.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/no_connection_error_view.dart';
import 'package:osk_flutter/view/common/styled_circular_progress_indicator.dart';
import 'package:osk_flutter/view/interview/bloc.dart';
import 'package:osk_flutter/view/interview/interview_negative_results_page.dart';
import 'package:osk_flutter/view/interview/interview_positivie_results_page.dart';
import 'package:osk_flutter/view/interview/interview_question_body.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';

class InterviewPage extends StatelessWidget {
  static MaterialPageRoute pageRoute() => MaterialPageRoute(builder: (BuildContext context) => InterviewPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InterviewBloc>(
      create: (context) => InterviewBloc(
        GetInerviewQuestionsUseCase(context.repository<FirebaseRepository>()),
        GetUserUseCase(context.repository<UserRepository>()),
        UpdateUserUseCase(context.repository<UserRepository>()),
      )..add(LoadData()),
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: const IntroAppBar(
          backgroundColor: Color(0XFF2618E8),
          appBarTheme: IntroAppBarTheme.light,
        ),
        backgroundColor: Color(0XFF2618E8),
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
      ),
      onWillPop: () async => false,
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<InterviewBloc, InterviewState>(
      listener: (BuildContext context, InterviewState state) {
        if (state is ShowPositiveResultsState) {
          Navigator.pushReplacement(context, InterviewPositiveResultsPage.pageRoute());
        }

        if (state is ShowNegativeResultsState) {
          Navigator.pushReplacement(context, InterviewNegativeResultsPage.pageRoute());
        }
      },
      buildWhen: (_, newState) => !(newState is ShowPositiveResultsState) && !(newState is ShowNegativeResultsState),
      builder: (BuildContext context, InterviewState state) {
        if (state is ShowQuestionState) {
          return InterviewQuestionBody(state);
        }

        if (state is ErrorState) {
          return NoConnectionErrorView(
            exception: state.exception,
            onRetryClick: () => BlocProvider.of<InterviewBloc>(context).add(LoadData()),
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
