import 'dart:async';

import '../constant/constant.dart';
import '../database/postgres.dart';
import '../log/log.dart';
import '../model/user.dart';
import '../validate/email.dart';

class IUserRepo {
  void login(String email, String password) {}
  void register(User user) {}
  void findUserByEmail(String email) {}
}

class UserRepository implements IUserRepo {
  UserRepository(this._db, this._logger);
  final Database _db;
  final AppLogger _logger;
  
  @override
  void login(String email, String password) {
    
  }

  @override
  void register(User user) {
  }

  @override
  Future<User> findUserByEmail(String email) async {
    _logger.log.info('findUserByEmail >> email = $email');

    final completer = Completer<User>();
    const query = 'SELECT * FROM users where email = @email';
    final params = {
            'email': email
          };
    final result = await _db.executor.query(query, substitutionValues: params);
    if (result.isEmpty) {
      _logger.debugSql(query, params, message: ExSql.statusRecordNotFound.toString());
      completer.completeError(ExSql.statusRecordNotFound);
      return completer.future;
    }

    final firstRow = result.first.toColumnMap();
    completer.complete(User(
      fullName: firstRow['full_name'].toString(),
      email: firstRow['email'].toString(),
    ));
    _logger.debugSql(query, params, result: firstRow);

    return completer.future;
  }
}
