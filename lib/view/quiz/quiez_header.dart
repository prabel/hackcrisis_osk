import 'package:flutter/material.dart';

class QuizHeader extends StatelessWidget {
  final int currentIndex;
  final int totalNumberOfQuestions;

  const QuizHeader({Key key, this.currentIndex, this.totalNumberOfQuestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Podstawowa wiedza o koronawirusie",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${currentIndex + 1}/$totalNumberOfQuestions",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
