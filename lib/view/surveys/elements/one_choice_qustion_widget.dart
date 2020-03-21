import 'package:flutter/material.dart';
import 'package:osk_flutter/view/surveys/elements/choice_item.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

typedef OnChoiceSelect(QuestionChoiceOption selectedChoice);

class OneChoiceQuestionWidget<T> extends StatefulWidget {
  final List<QuestionChoiceOption<T>> options;
  final OnChoiceSelect onChoiceSelect;
  final bool showQuestionMark;

  const OneChoiceQuestionWidget({Key key, this.options, this.onChoiceSelect, this.showQuestionMark = true})
      : super(key: key);

  @override
  _OneChoiceQuestionWidgetState<T> createState() => _OneChoiceQuestionWidgetState<T>();
}

class _OneChoiceQuestionWidgetState<T> extends State<OneChoiceQuestionWidget> {
  QuestionChoiceOption<T> selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options
          .map((item) => ChoiceItem(
                questionChoiceOption: item,
                isChecked: item == selectedItem,
                showQuestionMark: widget.showQuestionMark,
                onClick: () {
                  setState(() {
                    selectedItem = item;
                    widget.onChoiceSelect(selectedItem);
                  });
                },
              ))
          .toList(),
    );
  }
}
