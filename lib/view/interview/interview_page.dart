import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/interview/interview_form.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';

class InterviewPage extends StatelessWidget {
  static MaterialPageRoute pageRoute(InterviewForm interviewForm) =>
      MaterialPageRoute(builder: (BuildContext context) => InterviewPage(interviewForm: interviewForm));

  final InterviewForm interviewForm;

  const InterviewPage({Key key, this.interviewForm = InterviewForm.example}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFED0428),
      appBar: const IntroAppBar(
        appBarTheme: IntroAppBarTheme.light,
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(AppImages.backgroundPng),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                const SizedBox(height: 42),
                Text(
                  "Podstawowy wywiad\nmedyczny",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (interviewForm.question != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    interviewForm.question,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const SizedBox(height: 36),
                Column(
                  children: interviewForm.answers.map((item) => _buildAnswerButton(item)).toList(),
                ),
                const SizedBox(height: 70),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAnswerButton(InterviewAnswer answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
            elevation: 4,
            color: answer.isPrimaryAnswer ? AppColors.primaryBlue : Colors.white,
            padding: EdgeInsets.all(14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              answer.title,
              style: TextStyle(
                fontSize: 18,
                color: answer.isPrimaryAnswer ? Colors.white : AppColors.darkGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {}),
      ),
    );
  }
}
