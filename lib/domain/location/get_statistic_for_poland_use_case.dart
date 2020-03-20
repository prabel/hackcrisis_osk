import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/model/statistic_model.dart';

class GetStatisticForPolandUseCase {
  final FirebaseRepository _firebaseRepository;

  GetStatisticForPolandUseCase(this._firebaseRepository);

  Future<StatisticModel> execute() => _firebaseRepository.getStatisticForPoland();
}
