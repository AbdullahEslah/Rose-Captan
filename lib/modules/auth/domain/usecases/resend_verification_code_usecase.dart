import 'package:rose_captain/modules/auth/domain/repositories/user_repository.dart';

class ResendVerificationCodeUsecase {
  final UserRepository userRepository;
  ResendVerificationCodeUsecase(this.userRepository);

  Future<void> resendVerificationCode(String mobile) async {
    await userRepository.resendOTPCode(mobile);
  }
}
