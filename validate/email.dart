import 'dart:core';
import 'package:email_validator/email_validator.dart';

import 'strings.dart';

bool isValidEmail(String? email) {
  if (isNullOrEmpty(email)) {
    return false;
  }
  return EmailValidator.validate(email!);
}
