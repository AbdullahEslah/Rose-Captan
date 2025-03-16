import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rose_captain/modules/auth/domain/usecases/driver_login_usecase.dart';
import 'package:rose_captain/modules/auth/domain/usecases/driver_verify_login_usecase.dart';
import 'package:rose_captain/modules/auth/domain/usecases/resend_verification_code_usecase.dart';
import 'package:rose_captain/modules/auth/presentation/enums/login_enum.dart';
import 'package:rose_captain/modules/auth/presentation/enums/verify_number_enum.dart';

class AuthProvider with ChangeNotifier {
  final DriverLoginUseCase driverLoginUseCase;
  final DriverVerifyLoginUseCase driverVerifyLoginUseCase;
  final ResendVerificationCodeUsecase resendVerificationCodeUsecase;
  AuthProvider(this.driverLoginUseCase, this.driverVerifyLoginUseCase,
      this.resendVerificationCodeUsecase);

  /// responsible for loading, failure or success state
  LoginEnum _loginState = LoginEnum.normal;
  LoginEnum get loginState => _loginState;

  VerifyNumberEnum _verifyState = VerifyNumberEnum.normal;
  VerifyNumberEnum get verifyState => _verifyState;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// *******************

  /// responsible for accessing textField and setting their data
  final TextEditingController _mobileTextFieldController =
      TextEditingController();
  TextEditingController? get mobileTextFieldController =>
      _mobileTextFieldController;

  final TextEditingController _verifyNumberTextFieldController =
      TextEditingController();
  TextEditingController? get verifyNumberTextFieldController =>
      _verifyNumberTextFieldController;

  @override
  void dispose() {
    _verifyNumberTextFieldController.dispose();
    _mobileTextFieldController.dispose();
    super.dispose();
  }

  void updateMobileTextField(String mobileNumber) {
    _mobileTextFieldController.text = mobileNumber;
    notifyListeners();
  }

  void updateVerifyNumberTextField(String verificationCode) {
    _verifyNumberTextFieldController.text = verificationCode;
    notifyListeners();
  }

  void setVerifyState(VerifyNumberEnum state) {
    _verifyState = state;
    notifyListeners();
  }

  // Reset to idle state
  void resetVerifyState() {
    _verifyState = VerifyNumberEnum.normal;
    notifyListeners();
  }

  void setLoginState(LoginEnum state) {
    _loginState = state;
    notifyListeners();
  }

  // Reset to idle state
  void resetLoginState() {
    _loginState = LoginEnum.normal;
    notifyListeners();
  }

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearFields() {
    _mobileTextFieldController.text = "";
    _verifyNumberTextFieldController.text = "";
    notifyListeners();
  }

  //  login the driver
  Future<void> loginDriver() async {
    //  validate user inputs
    if (_mobileTextFieldController.text.isEmpty == true) {
      setError("mobile field is empty!. please add your phone number");
      setLoginState(LoginEnum.error);
      return;
    }
    if (_mobileTextFieldController.text.length != 8) {
      setError("Invalid Mobile Number!. please add valid mobile number");
      setLoginState(LoginEnum.error);
      return;
    }
    //  show loading
    setLoginState(LoginEnum.loading);
    try {
      await driverLoginUseCase
          .loginDriver("05${_mobileTextFieldController.text}");
      setLoginState(LoginEnum.success);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setLoginState(LoginEnum.error);
      setError(
          "something went wrong if it's from us. it'll be fixed as soon as possible");
    }
  }

  Future<void> verifyDriverLoginOTP() async {
    if (_verifyNumberTextFieldController.text.isEmpty == true) {
      setError(
          "verification code field is empty!. please add verification code");
      setVerifyState(VerifyNumberEnum.error);
      return;
    }
    //  show loading
    setVerifyState(VerifyNumberEnum.loading);
    try {
      var response = await driverVerifyLoginUseCase.verifyDriverLogin(
          "05${_mobileTextFieldController.text}",
          _verifyNumberTextFieldController.text);
      if (response.statusCode == 200) {
        setVerifyState(VerifyNumberEnum.success);
      } else {
        setError(json.decode(response.body)["message"] ?? "");
        setVerifyState(VerifyNumberEnum.error);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      setError(
          "something went wrong if it's from us. it'll be fixed as soon as possible");
      setVerifyState(VerifyNumberEnum.error);
    }
  }

  Future<void> resendCodeOTP() async {
    //  show loading
    setVerifyState(VerifyNumberEnum.loading);
    try {
      await resendVerificationCodeUsecase
          .resendVerificationCode("05${_mobileTextFieldController.text}");
      setVerifyState(VerifyNumberEnum.normal);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setVerifyState(VerifyNumberEnum.error);
      setError(
          "something went wrong if it's from us. it'll be fixed as soon as possible");
    }
  }
}
