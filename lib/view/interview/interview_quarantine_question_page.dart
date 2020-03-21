import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/model/user_model.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/main/main_navigation_page.dart';

class InterviewQuarantineQuestionPage extends StatelessWidget {
  static MaterialPageRoute pageRoute() =>
      MaterialPageRoute(builder: (BuildContext context) => InterviewQuarantineQuestionPage());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: AppColors.redBase,
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
                    "Dziękujemy.\nCzy zostałeś objęta\nkwarantanną?",
                    style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold, height: 45 / 30),
                  ),
                  Spacer(),
                  PrimaryButton(
                    title: "Tak",
                    onClick: () => _handleClickOnNext(context, true),
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    title: "Nie",
                    onClick: () => _handleClickOnNext(context, false),
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async => false,
    );
  }

  Future _handleClickOnNext(BuildContext context, bool withQuarantine) async {
    final UserRepository userRepository = RepositoryProvider.of<UserRepository>(context);
    final UserModel userModel = await userRepository.getCurrentUserModel();
    userRepository.createOrUpdateUser(
      userModel.copyWith(
        presumablySick: withQuarantine,
        quarantineStartDate: withQuarantine ? DateTime.now() : null,
      ),
    );

    Navigator.pushAndRemoveUntil(context, MainNavigationPage.pageRoute(), (_) => false);
  }
}
