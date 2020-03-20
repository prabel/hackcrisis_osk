import 'dart:io';

import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';

class NoConnectionErrorView extends StatelessWidget {
  final VoidCallback onRetryClick;
  final dynamic exception;

  const NoConnectionErrorView({this.onRetryClick, this.exception});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 24),
          Text(
            "Uups...",
            style: TextStyle(
              color: AppColors.battleshipGray,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _getErrorMessage(context),
            style: TextStyle(
              color: AppColors.steelGrey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildRetryButton(context),
        ],
      ),
    );
  }

  String _getErrorMessage(BuildContext context) {
    if (exception != null && exception is! SocketException) {
      print("Error -> $exception\n");
      return exception.toString();
    }
    return "Wystąpił problem z pobieraniem danych";
  }

  Widget _buildRetryButton(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: FlatButton(
          color: Colors.transparent,
          padding: EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.silverDark, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Text("Spróbuj ponownie",
              style: TextStyle(
                fontSize: 17,
                color: AppColors.battleshipGray,
                fontWeight: FontWeight.bold,
              )),
          onPressed: onRetryClick),
    );
  }
}
