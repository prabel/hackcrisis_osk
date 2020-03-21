import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:osk_flutter/model/quiz_answer_model.dart';
import 'package:osk_flutter/model/quiz_question_model.dart';

abstract class QuizState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends QuizState {}

class ShowQuestionState extends QuizState {
  final QuizQuestionModel quizQuestionModel;
  final int currentIndex;
  final int totalNumberOfQuestions;

  ShowQuestionState(this.quizQuestionModel, this.currentIndex, this.totalNumberOfQuestions);

  @override
  List<Object> get props => [quizQuestionModel, currentIndex, totalNumberOfQuestions];
}

class ShowAnswerState extends QuizState {
  final QuizQuestionModel quizQuestionModel;
  final QuizAnswerModel quizAnswerModel;
  final int currentIndex;
  final int totalNumberOfQuestions;

  ShowAnswerState(this.quizQuestionModel, this.quizAnswerModel, this.currentIndex, this.totalNumberOfQuestions);

  @override
  List<Object> get props => [quizQuestionModel, quizAnswerModel, currentIndex, totalNumberOfQuestions];
}

class ShowResultsState extends QuizState {
  final HashMap<QuizQuestionModel, bool> answerMap;

  ShowResultsState(this.answerMap);
}

class ErrorState extends QuizState {
  final exception;

  ErrorState(this.exception);
}
