import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class QuizAnswerModel extends Equatable {
  final String text;
  final bool valid;

  const QuizAnswerModel({
    @required this.text,
    @required this.valid,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'text': this.text,
      'valid': this.valid,
    };
  }

  factory QuizAnswerModel.fromMap(Map<dynamic, dynamic> map) {
    return new QuizAnswerModel(
      text: map['text'] as String,
      valid: map['valid'] as bool,
    );
  }

  @override
  List<Object> get props => [text, valid];
}
