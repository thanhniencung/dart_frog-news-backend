import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../constant/constant.dart';
import '../../controllers/user_controller.dart';
import '../../exception/record_not_found.dart';
import '../../model/response.dart';

Future<Response> onRequest(RequestContext context, String email) async {
  if (context.request.method.value != 'GET') {
    return AppResponse().error(HttpStatus.methodNotAllowed, AppMsg.msgMethodNotAllow);
  }

  final userController = context.read<UserController>();
  try {
    final user = await userController.handleFindUserByEmail(email);
    return AppResponse().ok(HttpStatus.ok, user);
  } catch(e) {
    var statusCode = HttpStatus.internalServerError;
    if (e is RecordNotFound) {
      statusCode = HttpStatus.notFound;
    } 
    return AppResponse().error(statusCode, e.toString());
  }
}


