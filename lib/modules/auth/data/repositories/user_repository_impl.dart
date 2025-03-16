import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rose_captain/modules/auth/data/datasources/user_remote_datasource.dart';
import 'package:rose_captain/modules/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;
  UserRepositoryImpl(this.userRemoteDatasource);

  @override
  Future<void> loginOrCreateDriver(String mobile) async {
    await userRemoteDatasource.loginOrCreateDriver(mobile);
  }

  @override
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
      required File driverImage}) async {
    var response = await userRemoteDatasource.completeDriverProfile(
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

  @override
  Future<http.Response> verifyDriver(String mobile, String otpNumber) async {
    var response = await userRemoteDatasource.verifyDriver(mobile, otpNumber);
    return response;
  }

  @override
  Future<void> resendOTPCode(String mobile) async {
    await userRemoteDatasource.resendOTPCode(mobile);
  }
}
