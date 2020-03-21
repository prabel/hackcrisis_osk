import 'package:equatable/equatable.dart';
import 'package:osk_flutter/model/interview_question_model.dart';

abstract class InterviewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends InterviewEvent {}

class AnswerQuestion extends InterviewEvent {
  final InterviewQuestionModel quizQuestionModel;
  final String answer;

  AnswerQuestion(this.quizQuestionModel, this.answer);

  @override
  List<Object> get props => [answer, quizQuestionModel];
}
