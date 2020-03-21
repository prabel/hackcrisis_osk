import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/model/user_model.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/values/health_statuses.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/main/profile/profile_app_bar.dart';
import 'package:osk_flutter/view/quiz/quiz_intro_page.dart';
import 'package:osk_flutter/view/surveys/health_status_survey_page.dart';

class ProfileDashboard extends StatefulWidget {
  const ProfileDashboard({Key key}) : super(key: key);

  @override
  _ProfileDashboardState createState() => _ProfileDashboardState();
}

class _ProfileDashboardState extends State<ProfileDashboard> {
  UserModel _userModel;
  HealthStatus _healthStatus = HealthStatus.healthy;

  @override
  void initState() {
    super.initState();
    _getCurrectUserInformation();
  }

  void _getCurrectUserInformation() {
    RepositoryProvider.of<UserRepository>(context).getCurrentUserModel().then((userModel) {
      final HealthStatus healthStatus = userModel?.getHealthStatusOrNull();
      if (healthStatus != null) {
        setState(() {
          _userModel = userModel;
          _healthStatus = healthStatus;
        });
      } else {
        Navigator.push(context, HealthStatusSurveyPage.pageRoute()).then((_) {
          _getCurrectUserInformation();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ProfileAppBar(
          title: "Dzień dobry${_userModel?.name != null ? ",\nPaweł" : ""}",
          backgroundGradient: LinearGradient(
            colors: _healthStatus.getColors(),
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 32),
                _buildHealthStatusContainer(context),
                const SizedBox(height: 20),
                _builQuizCard(context),
                const SizedBox(height: 20),
                _buildDiagnosisContainer(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildHealthStatusContainer(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(HealthStatusSurveyPage.pageRoute());
      },
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
                color: _healthStatus.getColors()[0],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              _healthStatus.getDescription(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosisContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Twoja diagnoza",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Możliwe, że masz koronawirusa."
          "\nNie idź lekarza, ani do szpitala!"
          "\nJeśli poczujesz się gorzej, zadzwoń po pomoc medyczną.",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Kontakt z pomocą medyczną",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        _buildContactCard(),
        const SizedBox(height: 20),
        Center(
          child: PrimaryButton(
            width: 280,
            backgroundColor: Color(0XFFFF4E00),
            height: 47,
            title: "Pilna pomoc medyczna: 112",
            onClick: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Powiatowa Stacja Sanitarno-Epidemiologiczna",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.lightGrey,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: PrimaryButton(
                width: 280,
                height: 47,
                title: "Zadzwoń: 89 767 23 22",
                onClick: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _builQuizCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, QuizIntroPage.pageRoute());
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
            colors: [Color(0XFFC8005D), Color(0XFFE41756)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  AppImages.icQuizPng,
                  height: 120,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Podstawowa wiedza\no koronawirusie\nCOVID-19",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    "Sprawdź się teraz",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
