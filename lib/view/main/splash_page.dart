import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/styled_circular_progress_indicator.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/intro/intro_page.dart';
import 'package:osk_flutter/view/main/main_navigation_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    RepositoryProvider.of<UserRepository>(context).getCurrentUserModel().then((userModel) {
      if (userModel?.name != null) {
        Navigator.pushReplacement(context, MainNavigationPage.pageRoute());
      } else {
        Navigator.pushReplacement(context, IntroPage.pageRoute());
      }
    }, onError: (e) {
      Navigator.pushReplacement(context, IntroPage.pageRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const IntroAppBar(),
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(AppImages.background),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Dzień dobry,\nto Twój Osobisty\nSystem Komunikacji",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              StyledCircularProgressIndicator(),
            ],
          )),
        ],
      ),
    );
  }
}
