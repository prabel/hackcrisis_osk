import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/quiz/quiz_page.dart';

class QuizIntroPage extends StatelessWidget {
  static MaterialPageRoute pageRoute() => MaterialPageRoute(builder: (BuildContext context) => QuizIntroPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const IntroAppBar(),
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(AppImages.background),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Quiz: podstawowa wiedza\no koronawirusie",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                _getCheckmarkItem("Posłuchaj wypowiedzi specjalistów."),
                const SizedBox(height: 20),
                _getCheckmarkItem("Odpowiedz na pytania."),
                const SizedBox(height: 20),
                _getCheckmarkItem("Utrwal swoją wiedzę."),
                const SizedBox(height: 20),
                _getCheckmarkItem("Podziel się swoim wynikiem!"),
                const SizedBox(height: 50),
                PrimaryButton(
                  title: "Dalej",
                  onClick: () => Navigator.pushReplacement(context, QuizPage.pageRoute()),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCheckmarkItem(String text) {
    return Row(
      children: <Widget>[
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: AppColors.darkGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
