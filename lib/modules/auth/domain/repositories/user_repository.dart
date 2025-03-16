import 'dart:io';

import 'package:http/http.dart' as http;

abstract class UserRepository {
  //used for login or create driver
  Future<void> loginOrCreateDriver(String mobile);
  Future<http.Response> verifyDriver(String mobile, String otpNumber);
  Future<void> resendOTPCode(String mobile);
  Future<http.Response> completeDriverProfile(
      {required String driverName,
      required String mobile,
      required String idNumber,
      required String carType,
      required String numOfPassengers,
      required String carModel,
      required String carColor,
      required String licenseNumber,
      required String companyName,
      required String companyLocation,
      required String companyRegistrationNum,
      required String companyType,
      required String lang,
      required File imageId,
      required File carImage,
      required File licenseImage,
      required File driverImage});
}
