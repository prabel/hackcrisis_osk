import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/assistance_statuses.dart';

class AssistanceInformationHolder extends StatelessWidget {
  final AssistanceStatus _assistanceStatus;

  const AssistanceInformationHolder(this._assistanceStatus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FlutterWebBrowser.openWebPage(
            url: "https://www.gov.pl/web/koronawirus/", androidToolbarColor: AppColors.primaryBlue);
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
                  _assistanceStatus.getAdditionalInformation(),
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
