import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osk_flutter/model/quiz_question_model.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/optional_button.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/quiz/quiz_page.dart';

class QuizResultsPage extends StatelessWidget {
  static MaterialPageRoute pageRoute(HashMap<QuizQuestionModel, bool> quizAnswers) =>
      MaterialPageRoute(builder: (BuildContext context) => QuizResultsPage(quizAnswers));

  final HashMap<QuizQuestionModel, bool> _quizAnswers;

  const QuizResultsPage(this._quizAnswers, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool fullCorrect = !_quizAnswers.containsValue(false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const IntroAppBar(),
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(AppImages.background),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(height: 20),
                  _buildQuizResultsBody(context),
                  if (!fullCorrect) ...[
                    const SizedBox(height: 20),
                    PrimaryButton(
                      title: "Odpowiedz jeszcze raz",
                      onClick: () =>
                          Navigator.pushReplacement(context, QuizPage.pageRoute(questions: _getOnlyFailedQuestions())),
                    )
                  ],
                  const SizedBox(height: 10),
                  fullCorrect
                      ? PrimaryButton(
                          title: "Podziel się",
                          onClick: () => Navigator.pop(context),
                        )
                      : OptionalButton(
                          title: "Podziel się",
                          onClick: () => Navigator.pop(context),
                        ),
                  const SizedBox(height: 10),
                  FlatButton(
                    child: Text(
                      "Zamknij",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizResultsBody(BuildContext context) {
    final List<bool> allAnswers = _quizAnswers.values.toList();
    final int correctAnswerCount = allAnswers.where((it) => it).toList().length;
    final int wrongAnswerCount = allAnswers.where((it) => !it).toList().length;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                border:
                    Border.all(color: _getBorderColorBaseOnResults(correctAnswerCount / allAnswers.length), width: 10),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${((correctAnswerCount / allAnswers.length) * 100).round()}%",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$correctAnswerCount/${allAnswers.length}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withAlpha(150),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        Text(
          wrongAnswerCount == 0
              ? "Gratulacje! Nie zapomnij przekazać swojej wiedzy innym i podzielić się testem ze znajomymi."
              : "Nie jest źle, ale lepiej wiedzieć wszystko! Odpowiedz jeszcze raz na pytania, na które nie udało Ci "
                  "się odpowiedzieć poprawnie, albo podziel się testem ze znajomymi.",
          style: TextStyle(
            fontSize: 17,
            color: AppColors.darkGrey,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  List<QuizQuestionModel> _getOnlyFailedQuestions() {
    _quizAnswers.removeWhere((key, value) => value);
    return _quizAnswers.keys.toList();
  }

  Color _getBorderColorBaseOnResults(double result) {
    if (result == 1.0) return AppColors.primaryBlue;
    if (result > 0.5) return Color(0XFFEFB700);

    return AppColors.redBase;
  }
}
