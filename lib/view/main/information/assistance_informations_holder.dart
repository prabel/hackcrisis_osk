import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:osk_flutter/model/assistance_extra_information_model.dart';
import 'package:osk_flutter/values/app_colors.dart';

class AssistanceInformationHolder extends StatelessWidget {
  final AssistanceExtraInformationModel assistanceExtraInformationModel;

  const AssistanceInformationHolder(this.assistanceExtraInformationModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FlutterWebBrowser.openWebPage(
            url: assistanceExtraInformationModel.url, androidToolbarColor: AppColors.primaryBlue);
      },
      child: Container(
        width: double.infinity,
        color: AppColors.primaryBlue,
        child: Row(
          children: <Widget>[
            Container(height: 44, width: 0),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  assistanceExtraInformationModel.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 14,
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
