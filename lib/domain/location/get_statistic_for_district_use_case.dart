import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/model/statistic_model.dart';

class GetStatisticForDistrictUseCase {
  final FirebaseRepository _firebaseRepository;

  GetStatisticForDistrictUseCase(this._firebaseRepository);

  Future<StatisticModel> execute(String districtName) => _firebaseRepository.getStatisticForDistrict(districtName);
}
