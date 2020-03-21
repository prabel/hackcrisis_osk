import 'package:equatable/equatable.dart';
import 'package:osk_flutter/values/assistance_statuses.dart';
import 'package:osk_flutter/values/health_statuses.dart';

class UserModel extends Equatable {
  final String name;
  final String age;
  final int healthStatusId;
  final List<int> assistanceStatusIds;

  UserModel({this.name, this.age, this.healthStatusId, this.assistanceStatusIds});

  Map<dynamic, dynamic> toMap() {
    return {
      'name': this.name,
      'age': this.age,
      'healthStatusId': this.healthStatusId,
      'assistanceStatusIds': this.assistanceStatusIds,
    };
  }

  factory UserModel.empty() {
    return UserModel();
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      name: map['name'],
      age: map['age'],
      healthStatusId: map['healthStatusId'],
      assistanceStatusIds: map['assistanceStatusIds'] != null ? (map['assistanceStatusIds'] as List).cast<int>() : [],
    );
  }

  UserModel copyWith({
    String name,
    String age,
    int healthStatusId,
    List<int> assistanceStatusIds,
  }) {
    return new UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      healthStatusId: healthStatusId ?? this.healthStatusId,
      assistanceStatusIds: assistanceStatusIds ?? this.assistanceStatusIds,
    );
  }

  @override
  List<Object> get props => [name, age, healthStatusId, assistanceStatusIds];

  HealthStatus getHealthStatusOrNull() {
    if (healthStatusId != null) {
      return HealthStatus.values[healthStatusId];
    }
    return null;
  }

  List<AssistanceStatus> getAssistaanceStatuses() {
    if (assistanceStatusIds != null) {
      return assistanceStatusIds.map((it) => AssistanceStatus.values[it]).toList();
    }
    return [];
  }
}
