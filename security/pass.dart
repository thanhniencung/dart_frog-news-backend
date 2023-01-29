import 'package:dbcrypt/dbcrypt.dart';

String genPass(String plainPassword) {
  return DBCrypt().hashpw(plainPassword, DBCrypt().gensalt());
}

bool verifyPass(String plainPassword, String dbPassword) {
  return DBCrypt().checkpw(plainPassword, dbPassword);
}
