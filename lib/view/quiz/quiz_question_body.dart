import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/model/quiz_answer_model.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/quiz/bloc.dart';
import 'package:osk_flutter/view/quiz/quiez_header.dart';
import 'package:osk_flutter/view/surveys/elements/one_choice_qustion_widget.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

class QuizQuestionBody extends StatefulWidget {
  final ShowQuestionState showQuestionState;

  QuizQuestionBody(this.showQuestionState);

  @override
  _QuizQuestionBodyState createState() => _QuizQuestionBodyState();
}

class _QuizQuestionBodyState extends State<QuizQuestionBody> {
  QuizAnswerModel _selectedanswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                QuizHeader(
                  currentIndex: widget.showQuestionState.currentIndex,
                  totalNumberOfQuestions: widget.showQuestionState.totalNumberOfQuestions,
                ),
                const SizedBox(height: 20),
                Text(
                  widget.showQuestionState.quizQuestionModel.question,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                OneChoiceQuestionWidget<QuizAnswerModel>(
                  showQuestionMark: false,
                  options: _mapAnswersToChoiceOptions(),
                  onChoiceSelect: (choice) {
                    _selectedanswer = choice.option;
                  },
                ),
              ],
            ),
          ),
        ),
        PrimaryButton(
          title: "Dalej",
          onClick: () {
            if (_selectedanswer != null) {
              BlocProvider.of<QuizBloc>(context).add(AnswerQuestion(
                widget.showQuestionState.quizQuestionModel,
                _selectedanswer,
              ));
            }
          },
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  List<QuestionChoiceOption> _mapAnswersToChoiceOptions() => widget.showQuestionState.quizQuestionModel.answers
      .map(
        (item) => QuestionChoiceOption(
          item,
          item.text,
          [AppColors.primaryBlue, AppColors.primaryBlue],
        ),
      )
      .toList();
}
