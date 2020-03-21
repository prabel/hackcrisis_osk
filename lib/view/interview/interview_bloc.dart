import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/domain/interview/get_interview_questions_use_case.dart';
import 'package:osk_flutter/domain/user/get_user_use_case.dart';
import 'package:osk_flutter/domain/user/update_user_use_case.dart';
import 'package:osk_flutter/model/interview_question_model.dart';
import 'package:osk_flutter/model/user_model.dart';

import 'bloc.dart';

class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {
  final GetInerviewQuestionsUseCase _getInterviewQuestionsUseCase;
  final GetUserUseCase _getUserUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  HashMap<InterviewQuestionModel, String> _answerMap = HashMap<InterviewQuestionModel, String>();
  List<InterviewQuestionModel> _interviewQuestions = [];
  int _currentQuestionIndex = 0;

  InterviewBloc(this._getInterviewQuestionsUseCase, this._getUserUseCase, this._updateUserUseCase);

  @override
  InterviewState get initialState => LoadingState();

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print("Error -> $error\n$stacktrace");
  }

  @override
  Stream<InterviewState> mapEventToState(InterviewEvent event) async* {
    if (event is LoadData) {
      if (_interviewQuestions.isNotEmpty) {
        yield ShowQuestionState(_interviewQuestions[_currentQuestionIndex]);
      } else {
        yield LoadingState();
        try {
          _interviewQuestions = await _getInterviewQuestionsUseCase.execute();
          if (_interviewQuestions.isEmpty) {
            yield ErrorState("Brak pytań do Interviewu");
          }
          yield ShowQuestionState(_interviewQuestions[_currentQuestionIndex]);
        } catch (e) {
          yield ErrorState(e);
        }
      }
    }

    if (event is AnswerQuestion) {
      _answerMap.update(event.quizQuestionModel, (_) => event.answer, ifAbsent: () => event.answer);

      if (_interviewQuestions.length > _currentQuestionIndex + 1) {
        _currentQuestionIndex = _currentQuestionIndex + 1;
        yield ShowQuestionState(_interviewQuestions[_currentQuestionIndex]);
      } else {
        final UserModel userModel = await _getUserUseCase.execute();

        int numberOfPositiveAnswers =
            _answerMap.values.where((it) => "Tak".toLowerCase().contains(it.toLowerCase())).toList().length;

        if (numberOfPositiveAnswers > 1) {
          await _updateUserUseCase.execute(userModel.copyWith(presumablySick: true));
          yield ShowNegativeResultsState();
        } else {
          await _updateUserUseCase.execute(userModel.copyWith(presumablySick: false));
          yield ShowPositiveResultsState();
        }
      }
    }
  }
}
