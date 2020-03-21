import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/model/user_model.dart';

class GetUserUseCase {
  final UserRepository _userRepository;

  GetUserUseCase(this._userRepository);

  Future<UserModel> execute() => _userRepository.getCurrentUserModel();
}
