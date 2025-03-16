import 'dart:io';

import '../repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class CompleteProfileUsecase {
  CompleteProfileUsecase(this.userRepository);
  final UserRepository userRepository;

  Future<http.Response> completeProfile(
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
      required File driverImage}) async {
    var response = await userRepository.completeDriverProfile(
        driverName: driverName,
        mobile: mobile,
        idNumber: idNumber,
        carType: carType,
        numOfPassengers: numOfPassengers,
        carModel: carModel,
        carColor: carColor,
        licenseNumber: licenseNumber,
        companyName: companyName,
        companyLocation: companyLocation,
        companyRegistrationNum: companyRegistrationNum,
        companyType: companyType,
        lang: lang,
        imageId: imageId,
        carImage: carImage,
        licenseImage: licenseImage,
        driverImage: driverImage);
    return response;
  }
}
