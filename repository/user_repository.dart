// ignore_for_file: body_might_complete_normally_nullable

import 'dart:async';

import 'package:uuid/uuid.dart';

import '../constant/constant.dart';
import '../constant/role.dart';
import '../database/postgres.dart';
import '../log/log.dart';
import '../model/user.dart';
import '../security/pass.dart';

class IUserRepo {
  Future<int>? saveUser(User user) {}
  void findUserByEmail(String? email, {bool? showPass}) {}
  void findUserByID(String? email, {bool? showPass}) {}
}

class UserRepository implements IUserRepo {
  UserRepository(this._db, this._logger);
  final Database _db;
  final AppLogger _logger;

  @override
  Future<int> saveUser(User user) async {
    _logger.log.info('register >> user = $user()');

    final completer = Completer<int>();
    const query = '''
          INSERT INTO users (id, full_name, email, password, role) 
          VALUES (@id, @full_name, @email, @password, @role)
        ''';
    final params = {
      'id': user.id,
      'full_name': user.fullName,
      'email': user.email,
      'password': user.password,
      'role': Role.member.name
    };
    final result = await _db.executor.query(
      query,
      substitutionValues: params,
    );
    if (result.affectedRowCount == 0) {
      completer.completeError(ExSql.insertRecordFailed);
    }

    _logger.debugSql(query, params, message: '{$result.affectedRowCount}');

    completer.complete(result.affectedRowCount);
    return completer.future;
  }

  @override
  Future<User> findUserByEmail(String? email, {bool? showPass = false}) async {
    _logger.log.info('findUserByEmail >> email = $email');

    final completer = Completer<User>();
    const query = 'SELECT * FROM users where email = @email';
    final params = {'email': email};
    final result = await _db.executor.query(query, substitutionValues: params);
    if (result.isEmpty) {
      _logger.debugSql(query, params,
          message: ExSql.statusRecordNotFound.toString());
      completer.completeError(ExSql.statusRecordNotFound);
      return completer.future;
    }

    final firstRow = result.first.toColumnMap();
    completer.complete(
      User(
        id: firstRow['id'].toString(),
        fullName: firstRow['full_name'].toString(),
        email: firstRow['email'].toString(),
        role: firstRow['role'].toString(),
        password: showPass! ? firstRow['password'].toString() : null,
      ),
    );
    _logger.debugSql(query, params, result: firstRow);

    return completer.future;
  }

  @override
  Future<User> findUserByID(String? id, {bool? showPass = false}) async {
    _logger.log.info('findUserByID >> id = $id');

    final completer = Completer<User>();
    const query = 'SELECT * FROM users where id = @id';
    final params = {'id': id};
    final result = await _db.executor.query(query, substitutionValues: params);
    if (result.isEmpty) {
      _logger.debugSql(query, params,
          message: ExSql.statusRecordNotFound.toString());
      completer.completeError(ExSql.statusRecordNotFound);
      return completer.future;
    }

    final firstRow = result.first.toColumnMap();
    completer.complete(
      User(
        id: firstRow['id'].toString(),
        fullName: firstRow['full_name'].toString(),
        email: firstRow['email'].toString(),
        role: firstRow['role'].toString(),
        password: showPass! ? firstRow['password'].toString() : null,
      ),
    );
    _logger.debugSql(query, params, result: firstRow);

    return completer.future;
  }
}
