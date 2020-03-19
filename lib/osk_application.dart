import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osk_flutter/generated/l10n.dart';
import 'package:osk_flutter/view/intro/intro_page.dart';

class OskApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      title: "Osobisty System Komunikacji",
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroPage(),
    );
  }
}
