import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/view/interview/bloc.dart';
import 'package:osk_flutter/view/surveys/elements/one_choice_qustion_widget.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

class InterviewQuestionBody extends StatefulWidget {
  final ShowQuestionState showQuestionState;

  InterviewQuestionBody(this.showQuestionState);

  @override
  _InterviewQuestionBodyState createState() => _InterviewQuestionBodyState();
}

class _InterviewQuestionBodyState extends State<InterviewQuestionBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                "Podstawowy wywiad medyczny",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.showQuestionState.interviewQuestionModel.question,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              OneChoiceQuestionWidget<String>(
                key: Key(widget.showQuestionState.interviewQuestionModel.question),
                showQuestionMark: false,
                options: _mapAnswersToChoiceOptions(),
                onChoiceSelect: (choice) {
                  BlocProvider.of<InterviewBloc>(context).add(AnswerQuestion(
                    widget.showQuestionState.interviewQuestionModel,
                    choice.option,
                  ));
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  List<QuestionChoiceOption> _mapAnswersToChoiceOptions() => widget.showQuestionState.interviewQuestionModel.answers
      .map(
        (item) => QuestionChoiceOption(
          item,
          item,
          [AppColors.primaryBlue, AppColors.primaryBlue],
          textColor: Colors.black,
        ),
      )
      .toList();
}
