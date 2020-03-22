import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/main/profile/profile_app_bar.dart';

class ApplicationsDashboard extends StatelessWidget {
  const ApplicationsDashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ProfileAppBar(
          title: "Pomocne\naplikacje",
          backgroundColor: Color(0XFF5B5B5B),
          height: 290,
        ),
        ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox(height: 170);
              } else if (index == 1) {
                return _buildApplicationCard("mObywatel", AppImages.applicationImage,
                    () => LaunchReview.launch(androidAppId: "pl.nask.mobywatel", iOSAppId: "1339613469"));
              } else {
                return _buildApplicationCard(
                  "Kwarantanna Domowa",
                  AppImages.quarantinePng,
                  () => LaunchReview.launch(androidAppId: "pl.nask.droid.kwarantannadomowa", iOSAppId: "1502997499"),
                );
              }
            },
            separatorBuilder: (context, _) {
              return const SizedBox(height: 20);
            },
            itemCount: 3)
      ],
    );
  }

  Card _buildApplicationCard(String applicationName, String imagePath, VoidCallback onClick) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Image.asset(imagePath),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    applicationName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  title: "Otwórz",
                  height: 47,
                  width: 142,
                  onClick: onClick,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
