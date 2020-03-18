import 'package:flutter/material.dart';
import 'package:osk_flutter/generated/l10n.dart';
import 'package:osk_flutter/view/main/main_navigation_page.dart';

class OskApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Osobisty System Komunikacji",
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainNavigationPage(),
    );
  }
}
