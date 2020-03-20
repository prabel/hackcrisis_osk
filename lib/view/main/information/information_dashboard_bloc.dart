import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:osk_flutter/domain/location/get_current_location_use_case.dart';
import 'package:osk_flutter/domain/location/get_statistic_for_district_use_case.dart';
import 'package:osk_flutter/domain/location/get_statistic_for_poland_use_case.dart';
import 'package:osk_flutter/model/statistic_model.dart';

abstract class StatisticEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends StatisticEvent {}

abstract class StatisticState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends StatisticState {}

class LoadedDataState extends StatisticState {
  final StatisticModel statisticForPoland;
  final StatisticModel statisticForCurrentDistrict;
  final String districtName;

  LoadedDataState({this.statisticForPoland, this.statisticForCurrentDistrict, this.districtName});

  @override
  List<Object> get props => [statisticForPoland, statisticForCurrentDistrict, districtName];
}

class ErrorState extends StatisticState {
  final exception;

  ErrorState(this.exception);
}

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final GetStatisticForPolandUseCase getStatisticForPolandUseCase;
  final GetStatisticForDistrictUseCase getStatisticForDistrictUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;

  StatisticBloc({
    this.getStatisticForPolandUseCase,
    this.getStatisticForDistrictUseCase,
    this.getCurrentLocationUseCase,
  });

  @override
  StatisticState get initialState => LoadingState();

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print("Error -> $error\n$stacktrace");
  }

  @override
  Stream<StatisticState> mapEventToState(StatisticEvent event) async* {
    if (event is LoadData) {
      yield LoadingState();
      try {
        final StatisticModel statisticModelForPoland = await getStatisticForPolandUseCase.execute();
        yield LoadedDataState(statisticForPoland: statisticModelForPoland);

        try {
          final Address currentAddress = await getCurrentLocationUseCase.execute();
          if (currentAddress != null) {
            final StatisticModel statisticModelForDistrict =
                await getStatisticForDistrictUseCase.execute(currentAddress.adminArea);

            yield LoadedDataState(
              statisticForPoland: statisticModelForPoland,
              statisticForCurrentDistrict: statisticModelForDistrict,
              districtName: currentAddress.adminArea,
            );
          }
        } catch (e) {
          print("Error during fetching statistic for district $e");
        }
      } catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
