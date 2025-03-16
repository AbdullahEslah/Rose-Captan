import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rose_captain/core/constants/apis.dart';

abstract class UserRemoteDatasource {
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

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;
  UserRemoteDatasourceImpl(this.client);

  @override
  Future<void> loginOrCreateDriver(String mobile) async {
    Map<String, dynamic> body = {"mobile": mobile};
    await client.post(Apis.getEndpoint(Apis.loginOrSignupDriver), body: body);
  }

  @override
  Future<http.Response> verifyDriver(String mobile, String otpNumber) async {
    Map<String, String?> body = {"mobile": mobile, "otp": otpNumber};
    http.Response response =
        await client.post(Apis.getEndpoint(Apis.verifyDriver), body: body);
    return response;
  }

  @override
  Future<void> resendOTPCode(String mobile) async {
    Map<String, String?> body = {"mobile": mobile};
    var response =
        await client.post(Apis.getEndpoint(Apis.resendOTPCode), body: body);
    print(response.body);
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
    Map<String, String> body = {
      "mobile": mobile,
      "name": driverName,
      "id_number": idNumber,
      "car_type": carType,
      "number_of_passengers": numOfPassengers,
      "car_model": carModel,
      "car_color": carColor,
      "licence_plate_number": licenseNumber,
      "company_name": companyName,
      "company_location": companyLocation,
      "company_registration_number": companyRegistrationNum,
      "company_type": companyType,
      "lang": lang
    };

    http.MultipartRequest request = http.MultipartRequest(
        'POST', Apis.getEndpoint(Apis.completeDriverProfile));
    //  send body to the request
    request.fields.addAll(body);
    //  send images to the request
    request.files
        .add(await http.MultipartFile.fromPath('id_image', imageId.path));
    request.files
        .add(await http.MultipartFile.fromPath('car_image', carImage.path));
    request.files.add(
        await http.MultipartFile.fromPath('license_image', licenseImage.path));
    request.files.add(
        await http.MultipartFile.fromPath('driver_image', driverImage.path));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return response;
    } else {
      print(response.body);
      return response;
    }
  }
}
