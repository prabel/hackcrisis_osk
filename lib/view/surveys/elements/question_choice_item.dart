import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuestionChoiceOption extends Equatable {
  final String id;
  final String title;
  final List<Color> indicatorColors;

  @override
  List<Object> get props => [title];

  const QuestionChoiceOption(this.id, this.title, this.indicatorColors);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionChoiceOption &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          indicatorColors == other.indicatorColors);

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ indicatorColors.hashCode;

  @override
  String toString() {
    return 'QuestionChoiceOption{' + ' id: $id,' + ' title: $title,' + ' indicatorColors: $indicatorColors,' + '}';
  }

  QuestionChoiceOption copyWith({
    String id,
    String title,
    List<Color> indicatorColors,
  }) {
    return new QuestionChoiceOption(
      id ?? id,
      title ?? title,
      indicatorColors ?? indicatorColors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'indicatorColors': this.indicatorColors,
    };
  }

  factory QuestionChoiceOption.fromMap(Map<String, dynamic> map) {
    return new QuestionChoiceOption(
      map['id'] as String,
      map['title'] as String,
      map['indicatorColors'] as List<Color>,
    );
  }
}
