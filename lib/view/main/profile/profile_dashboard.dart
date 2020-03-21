import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/model/user_model.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/app_images.dart';
import 'package:osk_flutter/values/health_statuses.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/interview/interview_call_question_page.dart';
import 'package:osk_flutter/view/main/profile/profile_app_bar.dart';
import 'package:osk_flutter/view/quiz/quiz_intro_page.dart';
import 'package:osk_flutter/view/surveys/health_status_survey_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileDashboard extends StatefulWidget {
  const ProfileDashboard({Key key}) : super(key: key);

  @override
  _ProfileDashboardState createState() => _ProfileDashboardState();
}

class _ProfileDashboardState extends State<ProfileDashboard> {
  static const String kPositiveDiagnosisText =
      "Twoje objawy nie wskazują na koronawirusa. Nie musisz dzwonić do stacji epidemiologicznej. Objawy grypy lecz lekami antygrypowymi. Pamiętaj o zachowaniu izolacji od innych domowników. Jeśli poczujesz się gorzej, zadzwoń po pomoc medyczną.";
  static const String kNegativeDiagnosisText =
      "Kwarantanna to trudne wyzwanie, ale możesz liczyć na wsparcie psychologiczne i medyczne. Więcej dowiesz się w zakładce 'informacje'. Jeśli nagle poczujesz się gorzej zadzwoń po pogotowie ratunkowe.";

  UserModel _userModel;
  HealthStatus _healthStatus = HealthStatus.healthy;
  bool _presumablySick = false;
  Timer _timer;
  DateTime _quarantineStartDate;

  @override
  void initState() {
    super.initState();
    _getCurrectUserInformation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _getCurrectUserInformation() {
    RepositoryProvider.of<UserRepository>(context).getCurrentUserModel().then((userModel) {
      final HealthStatus healthStatus = userModel?.getHealthStatusOrNull();
      if (healthStatus != null) {
        setState(() {
          _userModel = userModel;
          _healthStatus = healthStatus;
          _presumablySick = userModel.presumablySick ?? false;
          _quarantineStartDate = userModel.quarantineStartDate;
        });
        if (userModel.presumablySick && userModel?.quarantineStartDate == null) {
          _timer?.cancel();
          _timer = Timer(Duration(seconds: 5), () {
            Navigator.push(context, InterviewCallQuestionPage.pageRoute());
          });
        }
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
        _buildAppBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Text(
                  "Twoj stan zdrowia",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildHealthStatusContainer(context),
                if (!_presumablySick) ...[
                  const SizedBox(height: 20),
                  _builQuizCard(context),
                ],
                const SizedBox(height: 20),
                _buildDiagnosisContainer(),
                if (_presumablySick) ...[
                  const SizedBox(height: 20),
                  _builQuizCard(context),
                  const SizedBox(height: 20),
                ],
              ],
            ),
          ),
        )
      ],
    );
  }

  ProfileAppBar _buildAppBar() {
    if (_quarantineStartDate != null) {
      return ProfileAppBar(
        title: "Kwarantanna\n${(_quarantineStartDate.add(Duration(days: 15)).difference(DateTime.now()).inDays)} DNI",
        backgroundGradient: LinearGradient(
          colors: [AppColors.redBase, AppColors.redBase],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      );
    }
    return ProfileAppBar(
      title: "Dzień dobry${_userModel?.name != null ? ",\nPaweł" : ""}",
      backgroundGradient: LinearGradient(
        colors: _presumablySick ? [AppColors.redBase, AppColors.redBase] : _healthStatus.getColors(),
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    );
  }

  Widget _buildHealthStatusContainer(BuildContext context) {
    return InkWell(
      onTap: () {
        _timer?.cancel();
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
            Expanded(
              child: Text(
                _healthStatus.getDescription(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 12),
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
        const SizedBox(height: 16),
        Text(
          _presumablySick ? kNegativeDiagnosisText : kPositiveDiagnosisText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey,
          ),
        ),
        const SizedBox(height: 20),
        if (_quarantineStartDate != null) ...[
          _buildQuarantineApplicationCard(),
          const SizedBox(height: 20),
        ],
        Text(
          "Kontakt z pomocą medyczną",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        _buildContactCard(),
        const SizedBox(height: 20),
        Center(
          child: PrimaryButton(
            width: 290,
            height: 47,
            title: "Infolinia: 800 190 590",
            onClick: () {
              launch('tel:800190590');
            },
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: PrimaryButton(
            width: 290,
            backgroundColor: AppColors.redBase,
            height: 47,
            title: "Pilna pomoc medyczna: 112",
            onClick: () {
              launch('tel:112');
            },
          ),
        ),
      ],
    );
  }

  Widget _builQuizCard(BuildContext context) {
    return InkWell(
      onTap: () {
        _timer?.cancel();
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

  Widget _buildContactCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: Color(0XFFEBEBEB)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Powiatowa Stacja Sanitarno-Epidemiologiczna",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: PrimaryButton(
                width: 290,
                height: 47,
                title: "Zadzwoń: 89 767 23 22",
                onClick: () {
                  launch('tel:897672322');
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuarantineApplicationCard() {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Image.asset(AppImages.quarantinePng),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Kwarantanna Domowa",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  title: "Otwórz",
                  height: 47,
                  width: 142,
                  onClick: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
