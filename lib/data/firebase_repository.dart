import 'package:firebase_database/firebase_database.dart';
import 'package:osk_flutter/model/statistic_model.dart';

class FirebaseRepository {
  final DatabaseReference statisticNode = FirebaseDatabase.instance.reference().child("statistics");

  Future<StatisticModel> getStatisticForPoland() async {
    final DataSnapshot dataSnapshot = await statisticNode.child("poland").once();

    return StatisticModel.fromMap(dataSnapshot.value);
  }

  Future<StatisticModel> getStatisticForDistrict(String districtName) async {
    final DataSnapshot dataSnapshot = await statisticNode.child("districts").child(districtName).once();

    return StatisticModel.fromMap(dataSnapshot.value);
  }
}
