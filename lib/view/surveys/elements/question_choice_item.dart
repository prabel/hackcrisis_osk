import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuestionChoiceOption<T> extends Equatable {
  final T option;
  final String title;
  final List<Color> indicatorColors;
  final Color textColor;

  @override
  List<Object> get props => [title, option];

  const QuestionChoiceOption(this.option, this.title, this.indicatorColors, {this.textColor});
}
