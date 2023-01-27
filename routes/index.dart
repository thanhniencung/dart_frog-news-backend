import 'package:dart_frog/dart_frog.dart';

import '../repository/user_repository.dart';

Response onRequest(RequestContext context) {
  final userRepository = context.read<UserRepository>();
  userRepository.findUserByEmail('ryan@gmail.com');

  return Response(body: 'Welcome to Dart Frog!');
}
