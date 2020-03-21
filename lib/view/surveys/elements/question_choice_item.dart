import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuestionChoiceOption<T> extends Equatable {
  final T option;
  final String title;
  final List<Color> indicatorColors;

  @override
  List<Object> get props => [title, option];

  const QuestionChoiceOption(this.option, this.title, this.indicatorColors);

  @override
  String toString() {
    return 'QuestionChoiceOption{' +
        ' option: $option,' +
        ' title: $title,' +
        ' indicatorColors: $indicatorColors,' +
        '}';
  }
}
