import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/domain/quiz/get_quiz_questions_use_case.dart';
import 'package:osk_flutter/model/quiz_question_model.dart';

import 'bloc.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuizQuestionsUseCase getQuizQuestionsUseCase;

  HashMap<QuizQuestionModel, bool> _answerMap = HashMap<QuizQuestionModel, bool>();
  List<QuizQuestionModel> quizQuestions = [];
  int _currentQuestionIndex = 0;

  QuizBloc(this.getQuizQuestionsUseCase, this.quizQuestions);

  @override
  QuizState get initialState => LoadingState();

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print("Error -> $error\n$stacktrace");
  }

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is LoadData) {
      if (quizQuestions.isNotEmpty) {
        yield ShowQuestionState(quizQuestions[_currentQuestionIndex], _currentQuestionIndex, quizQuestions.length);
      } else {
        yield LoadingState();
        try {
          quizQuestions = await getQuizQuestionsUseCase.execute();
          if (quizQuestions.isEmpty) {
            yield ErrorState("Brak pytań do Quizu");
          }
          yield ShowQuestionState(quizQuestions[_currentQuestionIndex], _currentQuestionIndex, quizQuestions.length);
        } catch (e) {
          yield ErrorState(e);
        }
      }
    }

    if (event is AnswerQuestion) {
      final bool isCorrectAnswer = event.quizAnswerModel.valid;
      final QuizQuestionModel quizQuestionModel = event.quizQuestionModel;

      _answerMap.update(event.quizQuestionModel, (_) => isCorrectAnswer, ifAbsent: () => isCorrectAnswer);

      yield ShowAnswerState(quizQuestionModel, event.quizAnswerModel, _currentQuestionIndex, quizQuestions.length);
    }

    if (event is NextQuestion) {
      if (quizQuestions.length > _currentQuestionIndex + 1) {
        _currentQuestionIndex = _currentQuestionIndex + 1;
        yield ShowQuestionState(quizQuestions[_currentQuestionIndex], _currentQuestionIndex, quizQuestions.length);
      } else {
        yield ShowResultsState(_answerMap);
      }
    }
  }
}
