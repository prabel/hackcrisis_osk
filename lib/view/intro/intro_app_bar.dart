import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osk_flutter/values/app_images.dart';

enum IntroAppBarTheme { light, dark }

class IntroAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IntroAppBarTheme appBarTheme;

  const IntroAppBar({Key key, this.appBarTheme = IntroAppBarTheme.light}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        width: double.infinity,
        child: Center(
          child: Row(
            children: <Widget>[
              SizedBox(width: 22),
              Text(
                "Osobisty System\nKomunikacji",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appBarTheme == IntroAppBarTheme.light ? Colors.white : Colors.black,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(appBarTheme == IntroAppBarTheme.light ? AppImages.logoGovWhite : AppImages.logoGovBlack),
              SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(86);
}
