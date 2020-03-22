import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/intro/intro_step_one_page.dart';

class IntroPage extends StatelessWidget {
  static MaterialPageRoute pageRoute() => MaterialPageRoute(
        builder: (BuildContext context) => IntroPage(),
      );

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
                  "Dzień dobry,\nto Twój Osobisty\nSystem Komunikacji",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                _getCheckmarkItem("Prawdziwe informacje"),
                const SizedBox(height: 20),
                _getCheckmarkItem("Przydatne porady"),
                const SizedBox(height: 20),
                _getCheckmarkItem("Pomoc medyczna"),
                const SizedBox(height: 50),
                PrimaryButton(
                  title: "Rozpocznij",
                  onClick: () {
                    Navigator.pushReplacement(context, IntroStepOnePage.pageRoute());
                  },
                ),
                const SizedBox(height: 70),
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
        Icon(
          Icons.check,
          color: AppColors.primaryBlue,
        ),
        const SizedBox(width: 24),
        Text(
          text,
          style: TextStyle(
            fontSize: 17,
            color: AppColors.darkGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
