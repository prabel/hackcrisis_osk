import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/assistance_statuses.dart';
import 'package:osk_flutter/view/main/information/assistance_informations_holder.dart';
import 'package:osk_flutter/view/main/information/assistance_status_holder.dart';
import 'package:osk_flutter/view/main/profile/profile_app_bar.dart';
import 'package:osk_flutter/view/surveys/assistance_survey_page.dart';

class InformationDashboard extends StatefulWidget {
  const InformationDashboard({Key key}) : super(key: key);

  @override
  _InformationDashboardState createState() => _InformationDashboardState();
}

class _InformationDashboardState extends State<InformationDashboard> {
  List<AssistanceStatus> currentAssistanceStatus = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ProfileAppBar(
            title: "Paweł",
            backgroundColor: AppColors.turquoise,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                _buildAssistanceStatusHeader(),
                if (currentAssistanceStatus.isEmpty) ...[
                  _buildEmptyAssistanceStatusContainer(),
                ],
                if (currentAssistanceStatus.isNotEmpty) ...[
                  _buildAssistanceStatusesContainer(),
                  const SizedBox(height: 34),
                  Text(
                    "Wiedza dla Ciebie",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildInformationsBaseOnStatuses(),
                  const SizedBox(height: 40),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAssistanceStatusHeader() {
    return Row(
      children: <Widget>[
        Text(
          "Twoja sytuacja",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        FlatButton(
          child: Text(
            "Zmień",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          onPressed: () => _openAssistanceSurvey(),
        )
      ],
    );
  }

  Widget _buildInformationsBaseOnStatuses() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: currentAssistanceStatus
          .map((it) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: AssistanceInformationHolder(it),
              ))
          .toList(),
    );
  }

  Widget _buildAssistanceStatusesContainer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: currentAssistanceStatus
          .map((it) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: AssistanceStatusHolder(it),
              ))
          .toList(),
    );
  }

  Widget _buildEmptyAssistanceStatusContainer() {
    return InkWell(
      onTap: () => _openAssistanceSurvey(),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Color(0XFFEBEBEB)),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 8),
            Container(
              height: 44,
              width: 10,
              decoration: BoxDecoration(
                color: AppColors.turquoise,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "Dopasuj informacje",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.darkGrey,
            ),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  void _openAssistanceSurvey() {
    Navigator.push(context, AssistanceSurveyPage.pageRoute(currentAssistanceStatus)).then((value) {
      if (value != null && value is List<AssistanceStatus>) {
        setState(() {
          currentAssistanceStatus = value;
        });
      }
    });
  }
}
