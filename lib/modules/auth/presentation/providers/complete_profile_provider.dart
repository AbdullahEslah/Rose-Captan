import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rose_captain/core/utils/lang/app_language_provider.dart';
import 'package:rose_captain/modules/auth/domain/usecases/complete_profile_usecase.dart';
import 'package:rose_captain/modules/auth/presentation/enums/complete_profile_enum.dart';
import 'package:rose_captain/modules/auth/presentation/providers/auth_provider.dart';

class CompleteProfileProvider with ChangeNotifier {
  final CompleteProfileUsecase completeProfileUsecase;
  CompleteProfileProvider(this.completeProfileUsecase);

  /// responsible for loading, failure or success state
  CompleteProfileEnum _completeProfileState = CompleteProfileEnum.normal;
  CompleteProfileEnum get completeProfileState => _completeProfileState;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// *******************
  final TextEditingController _driverNameTextFieldController =
      TextEditingController();
  TextEditingController? get driverNameTextFieldController =>
      _driverNameTextFieldController;

  final TextEditingController _idNumberTextFieldController =
      TextEditingController();
  TextEditingController? get idNumberTextFieldController =>
      _idNumberTextFieldController;

  final TextEditingController _companyNameTextFieldController =
      TextEditingController();
  TextEditingController? get companyNameTextFieldController =>
      _companyNameTextFieldController;

  final TextEditingController _companyPlaceTextFieldController =
      TextEditingController();
  TextEditingController? get companyPlaceTextFieldController =>
      _companyPlaceTextFieldController;

  final TextEditingController _companyRegistrationNumberTextFieldController =
      TextEditingController();
  TextEditingController? get companyRegistrationNumberTextFieldController =>
      _companyRegistrationNumberTextFieldController;

  final TextEditingController _carTypeTextFieldController =
      TextEditingController();
  TextEditingController? get carTypeTextFieldController =>
      _carTypeTextFieldController;

  final TextEditingController _numOfPassengersTextFieldController =
      TextEditingController();
  TextEditingController? get numOfPassengersTextFieldController =>
      _numOfPassengersTextFieldController;

  final TextEditingController _carModelTextFieldController =
      TextEditingController();
  TextEditingController? get carModelTextFieldController =>
      _carModelTextFieldController;

  final TextEditingController _carColorTextFieldController =
      TextEditingController();
  TextEditingController? get carColorTextFieldController =>
      _carColorTextFieldController;

  final TextEditingController _licenseNumberTextFieldController =
      TextEditingController();
  TextEditingController? get licenseNumberTextFieldController =>
      _licenseNumberTextFieldController;

  final TextEditingController _companyTypeTextFieldController =
      TextEditingController();
  TextEditingController? get companyTypeTextFieldController =>
      _companyTypeTextFieldController;

  ///*****************

  String? _language;
  String? get language => _language;

  /// driver related images
  File? _idImage;
  File? get idImage => _idImage;

  File? _carImage;
  File? get carImage => _carImage;

  File? _licenseImage;
  File? get licenseImage => _licenseImage;

  File? _driverImage;
  File? get driverImage => _driverImage;

  /// mainPageView controller
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  int? _currentPageView;
  int get currentPageView => _currentPageView ?? 0;

  ///********************

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void setVerifyState(CompleteProfileEnum state) {
    _completeProfileState = state;
    notifyListeners();
  }

  // Reset to idle state
  void resetCompleteProfileState() {
    _completeProfileState = CompleteProfileEnum.normal;
    notifyListeners();
  }

  void updateCurrentPageView(int pageViewIndex) {
    _currentPageView = pageViewIndex;
    notifyListeners();
  }

  void updateDriverNameTextField(String driverName) {
    _driverNameTextFieldController.text = driverName;
    notifyListeners();
  }

  void updateIdNumberTextField(String idNumber) {
    _idNumberTextFieldController.text = idNumber;
    notifyListeners();
  }

  void updateCompanyNameTextField(String companyName) {
    _companyNameTextFieldController.text = companyName;
    notifyListeners();
  }

  void updateCompanyTypeTextField(String companyType) {
    _companyTypeTextFieldController.text = companyType;
    notifyListeners();
  }

  void updateCompanyPlaceTextField(String companyPlace) {
    _companyPlaceTextFieldController.text = companyPlace;
    notifyListeners();
  }

  void updateCompanyRegistrationTextField(String companyRegistrationNumber) {
    _companyRegistrationNumberTextFieldController.text =
        companyRegistrationNumber;
    notifyListeners();
  }

  void updateCarTypeTextField(String carType) {
    _carTypeTextFieldController.text = carType;
    notifyListeners();
  }

  void updateNumberOfPassengersTextField(String numOfPassengers) {
    _numOfPassengersTextFieldController.text = numOfPassengers;
    notifyListeners();
  }

  void updateCarModelTextField(String carModel) {
    _carModelTextFieldController.text = carModel;
    notifyListeners();
  }

  void updateCarColorTextField(String carColor) {
    _carColorTextFieldController.text = carColor;
    notifyListeners();
  }

  void updateLicenseTextField(String licenseNumber) {
    _licenseNumberTextFieldController.text = licenseNumber;
    notifyListeners();
  }

  //  pick an image method
  Future<XFile?> pickIdImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1920,
        maxWidth: 1080,
        imageQuality: 70,
        requestFullMetadata: false);
    if (pickedImage != null) {
      // Read the image as bytes
      final File imageFile = File(pickedImage.path);
      _idImage = imageFile;
      notifyListeners(); //  update screen state whenever _roomImageFile changes
    }
    return pickedImage;
  }

  Future<XFile?> pickCarImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1920,
        maxWidth: 1080,
        imageQuality: 70,
        requestFullMetadata: false);
    if (pickedImage != null) {
      // Read the image as bytes
      final File imageFile = File(pickedImage.path);
      _carImage = imageFile;
      notifyListeners(); //  update screen state whenever _roomImageFile changes
    }
    return pickedImage;
  }

  Future<XFile?> pickLicenseImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1920,
        maxWidth: 1080,
        imageQuality: 70,
        requestFullMetadata: false);
    if (pickedImage != null) {
      // Read the image as bytes
      final File imageFile = File(pickedImage.path);
      _licenseImage = imageFile;
      notifyListeners(); //  update screen state whenever _roomImageFile changes
    }
    return pickedImage;
  }

  Future<XFile?> pickDriverImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1920,
        maxWidth: 1080,
        imageQuality: 70,
        requestFullMetadata: false);
    if (pickedImage != null) {
      // Read the image as bytes
      final File imageFile = File(pickedImage.path);
      _driverImage = imageFile;
      notifyListeners(); //  update screen state whenever _roomImageFile changes
    }
    return pickedImage;
  }

  Future<void> completeProfile(BuildContext context) async {
    setVerifyState(CompleteProfileEnum.loading);
    try {
      final langProvider = Provider.of<AppLanguage>(context, listen: false);
      var response = await completeProfileUsecase.completeProfile(
          driverName: _driverNameTextFieldController.text,
          mobile: Provider.of<AuthProvider>(context, listen: false)
                  .mobileTextFieldController
                  ?.text ??
              "",
          idNumber: _idNumberTextFieldController.text,
          carType: _carTypeTextFieldController.text,
          numOfPassengers: _numOfPassengersTextFieldController.text,
          carModel: _carModelTextFieldController.text,
          carColor: _carColorTextFieldController.text,
          licenseNumber: _licenseNumberTextFieldController.text,
          companyName: _companyNameTextFieldController.text,
          companyLocation: _companyPlaceTextFieldController.text,
          companyRegistrationNum:
              _companyRegistrationNumberTextFieldController.text,
          companyType: _companyTypeTextFieldController.text,
          lang: langProvider.appLocal.toString(),
          imageId: _idImage ?? File(""),
          carImage: _carImage ?? File(""),
          licenseImage: _licenseImage ?? File(""),
          driverImage: _driverImage ?? File(""));
      if (response.statusCode == 200) {
        setVerifyState(CompleteProfileEnum.success);
      } else {
        setError(json.decode(response.body)["errors"]["mobile"][0] ?? "");
        setVerifyState(CompleteProfileEnum.error);
      }
      //setVerifyState(CompleteProfileEnum.success);
    } catch (e) {
      setError(e.toString());
      setVerifyState(CompleteProfileEnum.error);
    }
  }
}
