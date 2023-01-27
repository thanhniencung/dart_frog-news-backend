import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'database/postgres.dart';
import 'log/log.dart';

final database = Database(
  '192.168.1.12',
  5432,
  'news',
  dbUser: 'postgres',
  dbPass: 'code4func',
);

final appLogger = AppLogger();

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  await database.connect();
  appLogger.initLog();
  return serve(handler.use(setupHandler()), ip, port);
}

Middleware setupHandler() {
  return (handler) {
    return handler.use(
      provider<Database>(
        (context) => database,
      ),
    ).use(
      provider<AppLogger>(
        (context) => appLogger,
      ),
    );
  };
}
