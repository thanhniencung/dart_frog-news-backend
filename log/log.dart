
import 'package:logging/logging.dart';
class AppLogger {
  late Logger log;

  void initLog() {
    print('init log');
    Logger.root.level = Level.ALL; 
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });

    log = Logger('MyClassName');
  }

  void debugSql(String query, dynamic params, {dynamic result, String? message}) {
    log.info({ 
          'input': query,
          'params': params,
          'message': message,
          'result': result,
        });
  }
}
