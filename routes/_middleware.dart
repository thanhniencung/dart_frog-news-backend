import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import '../controllers/user_controller.dart';
import '../database/postgres.dart';
import '../log/log.dart';
import '../model/response.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';
import '../security/jwt.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(verifyJwt).use(injectionController());
}

Middleware injectionController() {
  return (handler) {
    return handler.use(
      provider<UserController>(
        (context) {
          final logger = context.read<AppLogger>();
          final db = context.read<Database>();
          return UserController(UserRepository(db, logger), logger);
        },
      ),
    );
  };
}

// Thiếu token or token có vấn đề là trả lỗi ngay
Handler verifyJwt(Handler handler) {
  return (context) async {
    try {
      if (context.request.url.toString().startsWith('user/register') ||
          context.request.url.toString().startsWith('user/login')) {
        // Forward the request to the respective handler.
        return await handler(context);
      }

      final headers = context.request.headers;
      final authInfo = headers['Authorization'];
      // Header: key = Authorization - value:  Bearer {token}
      // authInfo = Bearer {token}
      if (authInfo == null || !authInfo.startsWith('Bearer ')) {
        return Response(statusCode: HttpStatus.badRequest);
      }

      final token = authInfo.split(' ')[1];
      verifyToken(token);

      // Forward the request to the respective handler.
      final user = decodeToken(token);
      return await handler(context.provide<User>(() => user!));
    } catch (e) {
      return AppResponse().error(HttpStatus.badRequest, e.toString());
    }
  };
}
