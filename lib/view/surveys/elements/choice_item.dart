import 'package:flutter/material.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

class ChoiceItem extends StatelessWidget {
  final bool isChecked;
  final QuestionChoiceOption questionChoiceOption;
  final VoidCallback onClick;

  const ChoiceItem({
    Key key,
    this.questionChoiceOption,
    this.onClick,
    this.isChecked = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: isChecked ? _buildCheckContainer() : _buildUnCheckContainer(),
      ),
    );
  }

  Widget _buildCheckContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        gradient: LinearGradient(
          colors: questionChoiceOption.indicatorColors,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(height: 60, width: 0),
          const SizedBox(width: 8),
          Container(
            height: 44,
            width: 10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              questionChoiceOption.title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildUnCheckContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: Color(0XFFEBEBEB)),
      ),
      child: Row(
        children: <Widget>[
          Container(height: 60, width: 0),
          const SizedBox(width: 8),
          Container(
            height: 44,
            width: 10,
            decoration: BoxDecoration(
              color: questionChoiceOption.indicatorColors[0],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              questionChoiceOption.title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
