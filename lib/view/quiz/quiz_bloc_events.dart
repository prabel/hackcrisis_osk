import 'package:equatable/equatable.dart';
import 'package:osk_flutter/model/quiz_answer_model.dart';
import 'package:osk_flutter/model/quiz_question_model.dart';

abstract class QuizEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends QuizEvent {}

class AnswerQuestion extends QuizEvent {
  final QuizQuestionModel quizQuestionModel;
  final QuizAnswerModel quizAnswerModel;

  AnswerQuestion(this.quizQuestionModel, this.quizAnswerModel);

  @override
  List<Object> get props => [quizAnswerModel, quizQuestionModel];
}

class NextQuestion extends QuizEvent {}
