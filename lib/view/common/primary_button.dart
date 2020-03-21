import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onClick;
  final String title;
  final double height, width;
  final Color backgroundColor;
  final Color textColor;

  const PrimaryButton(
      {Key key,
      this.onClick,
      this.title,
      this.height = 60,
      this.width = double.infinity,
      this.backgroundColor = AppColors.primaryBlue,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: RaisedButton(
          elevation: 4,
          color: backgroundColor,
          padding: EdgeInsets.all(14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: onClick),
    );
  }
}
