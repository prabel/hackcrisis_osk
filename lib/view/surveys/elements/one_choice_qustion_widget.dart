import 'package:flutter/material.dart';
import 'package:osk_flutter/view/surveys/elements/choice_item.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

typedef OnChoiceSelect(QuestionChoiceOption selectedChoice);

class OneChoiceQuestionWidget extends StatefulWidget {
  final List<QuestionChoiceOption> options;
  final OnChoiceSelect onChoiceSelect;

  const OneChoiceQuestionWidget({Key key, this.options, this.onChoiceSelect}) : super(key: key);

  @override
  _OneChoiceQuestionWidgetState createState() => _OneChoiceQuestionWidgetState();
}

class _OneChoiceQuestionWidgetState extends State<OneChoiceQuestionWidget> {
  QuestionChoiceOption selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options
          .map((item) => ChoiceItem(
                questionChoiceOption: item,
                isChecked: item == selectedItem,
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
