import 'package:flutter/material.dart';
import 'package:osk_flutter/view/surveys/elements/choice_item.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

typedef OnChoiceSelect(List<QuestionChoiceOption> selectedChoices);

class MultipleChoiceQuestionWidget<T> extends StatefulWidget {
  final List<QuestionChoiceOption<T>> options;
  final OnChoiceSelect onChoiceSelect;

  const MultipleChoiceQuestionWidget({Key key, this.options, this.onChoiceSelect}) : super(key: key);

  @override
  _MultipleChoiceQuestionWidgetState<T> createState() => _MultipleChoiceQuestionWidgetState<T>();
}

class _MultipleChoiceQuestionWidgetState<T> extends State<MultipleChoiceQuestionWidget> {
  List<QuestionChoiceOption<T>> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options
          .map((item) => ChoiceItem(
                questionChoiceOption: item,
                isChecked: selectedItems.contains(item),
                onClick: () {
                  setState(() {
                    if (selectedItems.contains(item)) {
                      selectedItems.remove(item);
                    } else {
                      selectedItems.add(item);
                    }
                    widget.onChoiceSelect(selectedItems);
                  });
                },
              ))
          .toList(),
    );
  }
}
