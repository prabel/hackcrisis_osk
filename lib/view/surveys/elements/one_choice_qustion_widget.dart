import 'package:flutter/material.dart';

class QuestionChoiceOption {
  final String id;
  final String title;
  final Color indicatorColor;

  const QuestionChoiceOption(this.id, this.title, {this.indicatorColor});
}

typedef Widget OnChoiceSelect(QuestionChoiceOption selectedChoice);

class OneChoiceQuestionWidget extends StatefulWidget {
  final List<QuestionChoiceOption> options;
  final OnChoiceSelect onChoiceSelect;

  const OneChoiceQuestionWidget({Key key, this.options, this.onChoiceSelect}) : super(key: key);

  @override
  _OneChoiceQuestionWidgetState createState() => _OneChoiceQuestionWidgetState();
}

class _OneChoiceQuestionWidgetState extends State<OneChoiceQuestionWidget> {
  var _currentId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options
          .map((item) => RadioListTile<String>(
                groupValue: _currentId,
                title: Text("${item.title}"),
                value: item.id,
                onChanged: (val) {
                  setState(() {
                    _currentId = val;
                  });
                },
              ))
          .toList(),
    );
  }
}
