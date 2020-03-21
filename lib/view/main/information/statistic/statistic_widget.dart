import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/data/location_repository.dart';
import 'package:osk_flutter/domain/location/get_current_location_use_case.dart';
import 'package:osk_flutter/domain/location/get_statistic_for_district_use_case.dart';
import 'package:osk_flutter/domain/location/get_statistic_for_poland_use_case.dart';
import 'package:osk_flutter/model/statistic_model.dart';
import 'package:osk_flutter/utils/string_utils.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/view/common/no_connection_error_view.dart';
import 'package:osk_flutter/view/common/styled_circular_progress_indicator.dart';
import 'package:osk_flutter/view/main/information/information_dashboard_bloc.dart';

class StatisticWidget extends StatelessWidget {
  final FirebaseRepository firebaseRepository;

  const StatisticWidget(this.firebaseRepository);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisticBloc>(
      create: (context) => StatisticBloc(
        getStatisticForPolandUseCase: GetStatisticForPolandUseCase(firebaseRepository),
        getStatisticForDistrictUseCase: GetStatisticForDistrictUseCase(firebaseRepository),
        getCurrentLocationUseCase: GetCurrentLocationUseCase(context.repository<LocationRepository>()),
      )..add(LoadData()),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<StatisticBloc, StatisticState>(builder: (BuildContext context, StatisticState state) {
      if (state is LoadedDataState) {
        return _buildStatisticHolder(
          context,
          state.statisticForPoland,
          state.statisticForCurrentDistrict,
          state.districtName,
        );
      }

      if (state is ErrorState) {
        return NoConnectionErrorView(
          exception: state.exception,
          onRetryClick: () => BlocProvider.of<StatisticBloc>(context).add(LoadData()),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(12),
        child: Center(child: StyledCircularProgressIndicator()),
      );
    });
  }

  Widget _buildStatisticHolder(
    BuildContext context,
    StatisticModel statisticModelForPoland,
    StatisticModel statisticModelForDistrict,
    String districtName,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Zachorowania w całej Polsce",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 22),
        _StatisticDetailsWidget(statisticModelForPoland),
        const SizedBox(height: 22),
        if (statisticModelForDistrict != null) ...[
          Text(
            "Woj. ${capitalize(districtName)}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 22),
          _StatisticDetailsWidget(statisticModelForDistrict),
          const SizedBox(height: 22),
        ]
      ],
    );
  }
}

class _StatisticDetailsWidget extends StatelessWidget {
  final StatisticModel _statisticModel;

  const _StatisticDetailsWidget(this._statisticModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildRow(AppColors.redBase, "aktualnych zachorowań", _statisticModel.infected),
        const SizedBox(height: 22),
        _buildRow(Colors.black, "zgon z powodu COVID-19", _statisticModel.deaths),
        const SizedBox(height: 22),
        _buildRow(AppColors.greenBase, "osoby wyleczone", _statisticModel.cured),
      ],
    );
  }

  Row _buildRow(Color color, String title, int value) {
    return Row(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: 75,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Center(
                  child: Text(
                    "$value",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
