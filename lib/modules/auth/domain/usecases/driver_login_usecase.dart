import 'package:rose_captain/modules/auth/domain/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class DriverLoginUseCase {
  DriverLoginUseCase(this.userRepository);
  final UserRepository userRepository;

  Future<http.Response> loginDriver(String mobile) async {
    http.Response response = await userRepository.loginOrCreateDriver(mobile);
    return response;
  }
}
