import 'package:http/http.dart' as http;

import '../repositories/user_repository.dart';

class DriverVerifyLoginUseCase {
  DriverVerifyLoginUseCase(this.userRepository);
  final UserRepository userRepository;

  Future<http.Response> verifyDriverLogin(
      String mobile, String mobileNumberOTP) async {
    var response = userRepository.verifyDriver(mobile, mobileNumberOTP);
    return response;
  }
}
