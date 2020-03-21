import 'package:device_id/device_id.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:osk_flutter/model/user_model.dart';

class UserRepository {
  final DatabaseReference usersNode = FirebaseDatabase.instance.reference().child("users");

  Future createOrUpdateUser(UserModel userModel) async {
    DatabaseReference databaseReference = usersNode.child(await _getUserId());

    await databaseReference.set(userModel.toMap());
  }

  Future<UserModel> getCurrentUserModel() async {
    DataSnapshot dataSnapshot = await usersNode.child(await _getUserId()).once();
    if (dataSnapshot != null) {
      return UserModel.fromMap(dataSnapshot.value);
    }

    return UserModel.empty();
  }

  Future<String> _getUserId() => DeviceId.getID;
}
