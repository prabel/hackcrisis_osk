import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.iOS: CupertinoPageTransitionsBuilder()}),
        ),
        home: SplashPage(),
      ),
    );
  }
}
