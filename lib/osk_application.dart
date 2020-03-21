import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/data/location_repository.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/generated/l10n.dart';
import 'package:osk_flutter/view/main/splash_page.dart';

class OskApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    _initializeNotifications();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseRepository>(create: (_) => FirebaseRepository()),
        RepositoryProvider<LocationRepository>(create: (_) => LocationRepository()),
        RepositoryProvider<UserRepository>(create: (_) => UserRepository()),
      ],
      child: MaterialApp(
        title: "Osobisty System Komunikacji",
        localizationsDelegates: [S.delegate],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.iOS: CupertinoPageTransitionsBuilder()}),
        ),
        home: SplashPage(),
      ),
    );
  }

  Future<void> _initializeNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        AndroidInitializationSettings('@mipmap/ic_launcher'),
        IOSInitializationSettings(),
      ),
      onSelectNotification: onSelectNotification,
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }
}
