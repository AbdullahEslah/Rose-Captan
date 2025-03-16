import 'package:rose_captain/modules/auth/domain/repositories/user_repository.dart';

class DriverLoginUseCase {
  DriverLoginUseCase(this.userRepository);
  final UserRepository userRepository;

  Future<void> loginDriver(String mobile) async {
    await userRepository.loginOrCreateDriver(mobile);
  }
}
