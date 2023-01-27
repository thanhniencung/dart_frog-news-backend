import '../exception/email_invalid.dart';
import '../exception/record_not_found.dart';

class ExSql {
  static const statusRecordNotFound = RecordNotFound('record not found');
}

class ExBus {
  static const emailInvalid = EmailInvalid('email invalid');
}

class AppMsg {
  static const msgMethodNotAllow = 'Method not allowed';
}





