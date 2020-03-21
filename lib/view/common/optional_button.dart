import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';

class OptionalButton extends StatelessWidget {
  final VoidCallback onClick;
  final String title;
  final double height, width;

  const OptionalButton({
    Key key,
    this.onClick,
    this.title,
    this.height = 60,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: RaisedButton(
          elevation: 4,
          color: Colors.white,
          padding: EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), side: BorderSide(color: AppColors.primaryBlue, width: 1)),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: onClick),
    );
  }
}
