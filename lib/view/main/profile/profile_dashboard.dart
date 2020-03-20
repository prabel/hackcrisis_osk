import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/values/health_statuses.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/main/profile/profile_app_bar.dart';

class ProfileDashboard extends StatelessWidget {
  final HealthStatus currentHealthStatus;

  const ProfileDashboard({Key key, this.currentHealthStatus = HealthStatus.healthy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ProfileAppBar(
          title: "Paweł",
          backgroundGradient: LinearGradient(
            colors: currentHealthStatus.getColors(),
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
                _buildHealthStatusContainer(),
                const SizedBox(height: 20),
                _buildDiagnosisContainer(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildHealthStatusContainer() {
    return Container(
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
              color: currentHealthStatus.getColors()[0],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            currentHealthStatus.getDescription(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
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
}
