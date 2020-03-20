import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';

class StyledCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
        strokeWidth: 8,
      ),
    );
  }
}
