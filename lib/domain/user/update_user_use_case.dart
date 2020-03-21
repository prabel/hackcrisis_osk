import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/model/user_model.dart';

class UpdateUserUseCase {
  final UserRepository _userRepository;

  UpdateUserUseCase(this._userRepository);

  Future execute(UserModel userModel) => _userRepository.createOrUpdateUser(userModel);
}
