import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class StatisticModel extends Equatable {
  final int infected;
  final int cured;
  final int deaths;

  const StatisticModel({
    @required this.infected,
    @required this.cured,
    @required this.deaths,
  });

  @override
  String toString() {
    return 'StatisticModel{' + ' infected: $infected,' + ' cured: $cured,' + ' deaths: $deaths,' + '}';
  }

  StatisticModel copyWith({
    int infected,
    int cured,
    int deaths,
  }) {
    return new StatisticModel(
      infected: infected ?? this.infected,
      cured: cured ?? this.cured,
      deaths: deaths ?? this.deaths,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'infected': this.infected,
      'cured': this.cured,
      'deaths': this.deaths,
    };
  }

  factory StatisticModel.fromMap(Map<dynamic, dynamic> map) {
    return StatisticModel(
      infected: map['infected'] as int,
      cured: map['cured'] as int,
      deaths: map['deaths'] as int,
    );
  }

  @override
  List<Object> get props => [infected, cured, deaths];
}
