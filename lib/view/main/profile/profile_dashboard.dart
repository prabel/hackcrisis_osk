import 'package:flutter/material.dart';
import 'package:osk_flutter/view/main/profile/profile_app_bar.dart';

class ProfileDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: NestedScrollView(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Twój stan zdrowia",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Placeholder(fallbackHeight: 40),
            Text(
              "Twój sytuacja osobista",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Placeholder(fallbackHeight: 40),
            const SizedBox(height: 24),
            Card(
              child: Placeholder(fallbackHeight: 100),
            ),
            const SizedBox(height: 24),
            Text(
              "Zagrożenia w Twojej okolicy",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Placeholder(fallbackHeight: 100),
            )
          ],
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            ProfileAppBar(
              title: "Dzień dobry, Paweł",
            )
          ];
        },
      ),
    );
  }
}
