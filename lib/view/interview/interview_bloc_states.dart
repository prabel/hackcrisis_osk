import 'package:equatable/equatable.dart';
import 'package:osk_flutter/model/interview_question_model.dart';

abstract class InterviewState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends InterviewState {}

class ShowQuestionState extends InterviewState {
  final InterviewQuestionModel interviewQuestionModel;

  ShowQuestionState(this.interviewQuestionModel);

  @override
  List<Object> get props => [interviewQuestionModel];
}

class ShowPositiveResultsState extends InterviewState {}

class ShowNegativeResultsState extends InterviewState {}

class ErrorState extends InterviewState {
  final exception;

  ErrorState(this.exception);
}
