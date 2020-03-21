import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osk_flutter/values/app_images.dart';

enum IntroAppBarTheme { light, dark }

class IntroAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IntroAppBarTheme appBarTheme;
  final Color backgroundColor;
  final bool showBottomDash;

  const IntroAppBar({
    Key key,
    this.appBarTheme = IntroAppBarTheme.dark,
    this.backgroundColor = Colors.white,
    this.showBottomDash = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: backgroundColor,
      width: double.infinity,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "osobisty system\nkomunikacji",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: appBarTheme == IntroAppBarTheme.light ? Colors.white : Colors.black,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                      appBarTheme == IntroAppBarTheme.light ? AppImages.logoGovWhite : AppImages.logoGovBlack),
                ],
              ),
              SizedBox(height: 24),
              Visibility(
                visible: showBottomDash,
                child: Container(
                  height: 2.5,
                  width: 34,
                  color: appBarTheme == IntroAppBarTheme.light ? Colors.white : Color(0XFFCFCFCF),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(130);
}
