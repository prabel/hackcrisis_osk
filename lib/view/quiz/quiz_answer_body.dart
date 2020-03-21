import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/model/quiz_answer_model.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/quiz/bloc.dart';
import 'package:osk_flutter/view/quiz/quiez_header.dart';
import 'package:osk_flutter/view/surveys/elements/choice_item.dart';
import 'package:osk_flutter/view/surveys/elements/question_choice_item.dart';

class QuizAnswerBody extends StatelessWidget {
  final ShowAnswerState showAnswerState;

  QuizAnswerBody(this.showAnswerState);

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
                  currentIndex: showAnswerState.currentIndex,
                  totalNumberOfQuestions: showAnswerState.totalNumberOfQuestions,
                ),
                const SizedBox(height: 20),
                if (showAnswerState.quizAnswerModel.valid) ...[
                  Text(
                    "Twoja odpowiedź jest poprawna!",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.greenBase,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                ] else ...[
                  Text(
                    "Twoja odpowiedź jest niepoprawna!\nPoprawną odpowiedź zaznaczyliśmy\nna zielono.",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
                Text(
                  showAnswerState.quizQuestionModel.question,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildCorrectAnswer(context),
                if (!showAnswerState.quizAnswerModel.valid) ...[
                  const SizedBox(height: 30),
                  Text(
                    "Twoja odpowiedż:",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildWrongAnswer(context),
                ],
              ],
            ),
          ),
        ),
        PrimaryButton(
          title: "Dalej",
          onClick: () {
            BlocProvider.of<QuizBloc>(context).add(NextQuestion());
          },
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildCorrectAnswer(BuildContext context) {
    final QuizAnswerModel correctAnswerModel =
        showAnswerState.quizQuestionModel.answers.where((it) => it.valid).toList().first;
    return ChoiceItem(
      isChecked: true,
      showQuestionMark: false,
      questionChoiceOption: QuestionChoiceOption<QuizAnswerModel>(correctAnswerModel, correctAnswerModel.text, [
        const Color(0Xff3AC168),
        const Color(0XFF84C749),
      ]),
    );
  }

  Widget _buildWrongAnswer(BuildContext context) {
    return ChoiceItem(
      isChecked: true,
      showQuestionMark: false,
      questionChoiceOption: QuestionChoiceOption<QuizAnswerModel>(
        showAnswerState.quizAnswerModel,
        showAnswerState.quizAnswerModel.text,
        [
          const Color(0XFFB7B7B7),
          const Color(0XFFB7B7B7),
        ],
      ),
    );
  }
}
