import 'package:dart_frog/dart_frog.dart';
import '../controllers/user_controller.dart';
import '../database/postgres.dart';
import '../log/log.dart';
import '../repository/user_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger())
                .use(injectionController());
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
