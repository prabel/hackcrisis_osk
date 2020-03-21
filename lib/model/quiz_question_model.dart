import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:osk_flutter/model/quiz_answer_model.dart';

class QuizQuestionModel extends Equatable {
  final String question;
  final List<QuizAnswerModel> answers;
  final String videoUrl;

  QuizQuestionModel({
    @required this.question,
    @required this.answers,
    @required this.videoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answers': answers,
      "videoUrl": videoUrl,
    };
  }

  factory QuizQuestionModel.fromMap(Map<dynamic, dynamic> map) {
    return QuizQuestionModel(
      question: map['question'] as String,
      answers: (map['answers'] as List).map((it) => QuizAnswerModel.fromMap(it)).toList(),
      videoUrl: map['videoUrl'] != null ? map['videoUrl'] as String : null,
    );
  }

  @override
  List<Object> get props => [question, answers, videoUrl];
}
