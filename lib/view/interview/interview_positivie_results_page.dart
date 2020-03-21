import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/main/main_navigation_page.dart';

class InterviewPositiveResultsPage extends StatelessWidget {
  static MaterialPageRoute pageRoute() =>
      MaterialPageRoute(builder: (BuildContext context) => InterviewPositiveResultsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenBase,
      appBar: const IntroAppBar(
        backgroundColor: Colors.transparent,
        appBarTheme: IntroAppBarTheme.light,
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(AppImages.backgroundPng),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(height: 20),
                Text(
                  "Dziękujemy.\nTwoje objawy\nnie wskazują na koronawirusa",
                  style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold, height: 45 / 30),
                ),
                const SizedBox(height: 36),
                Text(
                  "Nie musisz dzwonić do stacji epidemiologicznej."
                  "\nPamiętaj o izolacji od innych domowników. Jeśli poczujesz"
                  "\nsię gorzej, skorzystaj ponownie"
                  "\nz aplikacji.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 35 / 20,
                  ),
                ),
                Spacer(),
                PrimaryButton(
                  title: "Rozumiem",
                  onClick: () => Navigator.pushAndRemoveUntil(context, MainNavigationPage.pageRoute(), (_) => false),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
