import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      appBar: const IntroAppBar(),
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(AppImages.background),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (interviewForm.title != null) ...[
                  const SizedBox(height: 42),
                  Text(
                    interviewForm.title,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if (interviewForm.subtitle != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    interviewForm.subtitle,
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
                const SizedBox(height: 36),
                const Spacer(),
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
                color: answer.isPrimaryAnswer ? Colors.white : AppColors.lightGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {}),
      ),
    );
  }
}
