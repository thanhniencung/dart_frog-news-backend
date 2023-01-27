import 'dart:async';
import '../constant/constant.dart';
import '../log/log.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';
import '../validate/email.dart';

class UserController {
  UserController(this._userRepository, this._logger);
  final UserRepository _userRepository;
  final AppLogger _logger;

  Future<User> handleFindUserByEmail(String email) {
    final completer = Completer<User>();
    if (!isValidEmail(email)) {
      _logger.log.info(ExBus.emailInvalid.toString());
      completer.completeError(ExBus.emailInvalid);
      return completer.future;
    }

    final user = _userRepository.findUserByEmail(email);
    completer.complete(user);
    
    return completer.future; 
  }
}
