import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/model/user_model.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/assistance_statuses.dart';
import 'package:osk_flutter/view/main/information/assistance_informations_holder.dart';
import 'package:osk_flutter/view/main/information/assistance_status_holder.dart';
import 'package:osk_flutter/view/main/information/statistic/statistic_widget.dart';
import 'package:osk_flutter/view/main/profile/profile_app_bar.dart';
import 'package:osk_flutter/view/surveys/assistance_survey_page.dart';

class InformationDashboard extends StatefulWidget {
  const InformationDashboard({Key key}) : super(key: key);

  @override
  _InformationDashboardState createState() => _InformationDashboardState();
}

class _InformationDashboardState extends State<InformationDashboard> {
  UserModel _userModel;
  List<AssistanceStatus> _currentAssistanceStatus = [];

  @override
  void initState() {
    super.initState();
    _getCurrectUserInformation();
  }

  void _getCurrectUserInformation() {
    RepositoryProvider.of<UserRepository>(context).getCurrentUserModel().then((userModel) {
      setState(() {
        _userModel = userModel;
        _currentAssistanceStatus = userModel?.getAssistaanceStatuses();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ProfileAppBar(
            title: "Dzień dobry${_userModel?.name != null ? ",\nPaweł" : ""}",
            backgroundColor: AppColors.turquoise,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                _buildAssistanceStatusHeader(),
                if (_currentAssistanceStatus.isEmpty) ...[
                  _buildEmptyAssistanceStatusContainer(),
                ],
                if (_currentAssistanceStatus.isNotEmpty) ...[
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
                ],
                const SizedBox(height: 24),
                StatisticWidget(RepositoryProvider.of<FirebaseRepository>(context))
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
      children: _currentAssistanceStatus
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
      children: _currentAssistanceStatus
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
    Navigator.push(context, AssistanceSurveyPage.pageRoute(_currentAssistanceStatus))
        .then((value) => _getCurrectUserInformation());
  }
}
