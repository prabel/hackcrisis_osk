import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:osk_flutter/view/main/main_navigation_page.dart';

class InterviewNegativeResultsPage extends StatelessWidget {
  static MaterialPageRoute pageRoute() =>
      MaterialPageRoute(builder: (BuildContext context) => InterviewNegativeResultsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Uważaj!\nTwoje objawy\nwskazują, że możesz\nmieć koronawirusa.",
                  style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold, height: 45 / 30),
                ),
                const SizedBox(height: 36),
                Text(
                  "Nie wychodź z domu, nie idź do lekarza. Natychmiast zadzwoń do stacji epidemiologicznej. Odpowiedni  numer telefonu znajdziesz po naciśnięciu przycisku poniżej.",
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
                  onClick: () => _handleClickOnNext(context),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _handleClickOnNext(BuildContext context) async {
    await _scheduleNotification();

    Navigator.pushAndRemoveUntil(context, MainNavigationPage.pageRoute(), (_) => false);
  }

  Future _scheduleNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id', 'your other channel name', 'your other channel description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await FlutterLocalNotificationsPlugin().schedule(
      0,
      'Osobisty system komunikacji',
      'Czy zadzwoniłaś już do stacji epidemiologicznej?',
      DateTime.now().add(Duration(seconds: 5)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }
}
