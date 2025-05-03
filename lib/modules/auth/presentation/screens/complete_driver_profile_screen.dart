import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rose_captain/core/custom_widgets/custom_text_field/custom_dropdown_textField.dart';
import 'package:rose_captain/modules/auth/presentation/providers/complete_profile_provider.dart';

import '../../../../core/custom_widgets/custom_text_field/text_field_widget.dart';
import '../enums/complete_profile_enum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompleteDriverProfileScreen extends StatelessWidget {
  CompleteDriverProfileScreen({super.key});

  static final GlobalKey<FormState> firstWidgetFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> secondWidgetFormKey =
      GlobalKey<FormState>();
  static final GlobalKey<FormState> thirdWidgetFormKey = GlobalKey<FormState>();
  final FocusNode nameFocus = FocusNode();
  final FocusNode idNumberFocus = FocusNode();
  final FocusNode companyNameFocus = FocusNode();
  final FocusNode companyTypeFocus = FocusNode();
  final FocusNode placeOfCompanyFocus = FocusNode();
  final FocusNode registrationCompanyNumFocus = FocusNode();
  final FocusNode carTypeFocus = FocusNode();
  final FocusNode numOfPassengersFocus = FocusNode();
  final FocusNode carModelFocus = FocusNode();
  final FocusNode carColorFocus = FocusNode();
  final FocusNode licenseFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          nameFocus.unfocus();
          idNumberFocus.unfocus();
          companyNameFocus.unfocus();
          companyTypeFocus.unfocus();
          placeOfCompanyFocus.unfocus();
          registrationCompanyNumFocus.unfocus();
          carTypeFocus.unfocus();
          numOfPassengersFocus.unfocus();
          carModelFocus.unfocus();
          carColorFocus.unfocus();
          licenseFocus.unfocus();
        },
        child: Consumer<CompleteProfileProvider>(
            builder: (context, completeProfileProvider, child) {
          return Column(
            children: [
              Stack(children: [
                Image.asset(
                  "assets/images/cover_auth_image.png",
                  fit: BoxFit.fill,
                  height: screenHeight * 0.35,
                ),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: SafeArea(
                      top: true,
                      child: SizedBox(
                        height: 55,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: CircleBorder(
                                side: BorderSide(style: BorderStyle.none),
                              ),
                            ),
                            onPressed: () {
                              if (completeProfileProvider.currentPageView ==
                                  0) {
                                Navigator.pop(context);
                              } else {
                                completeProfileProvider.pageController
                                    .previousPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                              }
                              /*
                            if current pageViewIndex == 1 || 2 || 3
                            => go previous pageView else pop
                           */
                              // if (completeProfileProvider.currentPageView == 1 ||
                              //     completeProfileProvider.currentPageView ==
                              //         2 ||
                              //     completeProfileProvider.currentPageView ==
                              //         3) {
                              //   completeProfileProvider.pageController
                              //       .previousPage(
                              //           duration:
                              //               const Duration(milliseconds: 500),
                              //           curve: Curves.easeInOut);
                              // } else {
                              //   Navigator.pop(context);
                              // }
                            },
                            child: Icon(
                              color: Colors.white,
                              appLocalizations.localeName == "en"
                                  ? CupertinoIcons.arrow_left_circle_fill
                                  : CupertinoIcons.arrow_right_circle_fill,
                              size: 30,
                            )),
                      ),
                    )),
                SafeArea(
                    child: (completeProfileProvider.currentPageView == 0)
                        ? Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Text(
                              appLocalizations.driverInformation,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18),
                            ),
                          )
                        : (completeProfileProvider.currentPageView == 1)
                            ? Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Text(appLocalizations.companyInformation,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18)))
                            : (completeProfileProvider.currentPageView == 2)
                                ? Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Text(appLocalizations.carInformation,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18)))
                                : (completeProfileProvider.currentPageView == 3)
                                    ? Align(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        child: Text(
                                            appLocalizations.requestedImages,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18)))
                                    : SizedBox()),
              ]),
              Expanded(
                child: Consumer<CompleteProfileProvider>(
                  builder: (context, completeProfileProvider, child) {
                    return getCurrentWidget(
                        completeProfileProvider: completeProfileProvider,
                        context: context);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  PageView buildPageView(
      CompleteProfileProvider completeProfileProvider, BuildContext context) {
    return PageView(
      onPageChanged: (pageIndex) =>
          completeProfileProvider.updateCurrentPageView(pageIndex),
      physics: const NeverScrollableScrollPhysics(),
      controller: completeProfileProvider.pageController,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      children: [
        firstWidget(completeProfileProvider, context),
        secondWidget(completeProfileProvider, context),
        thirdsWidget(completeProfileProvider, context),
        finalWidgetAttachedFiles(completeProfileProvider, context)
      ],
    );
  }

  Widget getCurrentWidget(
      {required BuildContext context,
      required CompleteProfileProvider completeProfileProvider}) {
    final state = completeProfileProvider.completeProfileState;

    switch (state) {
      case CompleteProfileEnum.normal:
        buildPageView(completeProfileProvider, context);
        break;

      case CompleteProfileEnum.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black54,
          ),
        );

      case CompleteProfileEnum.success:
        print("completeProfile screen in success state");
        /*
                    Ensure notifyListeners() is not
                    called during the build phase
                  */
        SchedulerBinding.instance.addPostFrameCallback((_) {
          // editRoomProvider.resetFields();

          // if (ScaffoldMessenger.of(context).mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
              'Your Profile Created Successfully!',
              style: TextStyle(color: Colors.green),
            )),
          );
          // }
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => CompleteDriverProfileScreen()),
          // );
          completeProfileProvider.resetCompleteProfileState();
          completeProfileProvider.resetCurrentPageView();
        });

      //  error
      case CompleteProfileEnum.error:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          completeProfileProvider.resetCurrentPageView();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                completeProfileProvider.errorMessage ?? "",
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
          completeProfileProvider.resetCurrentPageView();
          completeProfileProvider.resetCompleteProfileState();
        });
    }
    return buildPageView(completeProfileProvider, context);
  }

  SingleChildScrollView firstWidget(
      CompleteProfileProvider completeProfileProvider, BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: firstWidgetFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.driverName,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextFieldForm(
                controller:
                    completeProfileProvider.driverNameTextFieldController,
                onChanged: (nameChanged) => completeProfileProvider
                    .updateDriverNameTextField(nameChanged),
                keyboardType: TextInputType.text,
                placeholder: appLocalizations.driverName,
                emptyValueText: 'please type your name',
                focus: nameFocus,
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                appLocalizations.idNumber,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextFieldForm(
                controller: completeProfileProvider.idNumberTextFieldController,
                onChanged: (idChanged) =>
                    completeProfileProvider.updateIdNumberTextField(idChanged),
                keyboardType: TextInputType.number,
                placeholder: appLocalizations.idNumber,
                emptyValueText: 'please type your id number',
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                minLength: 10,
                minLengthErrorText: 'ID Number must be at least 10 numbers',
                focus: idNumberFocus,
              ),
              SizedBox(height: screenHeight * 0.04),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue[900],
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    if (firstWidgetFormKey.currentState!.validate()) {
                      completeProfileProvider.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    }
                  },
                  child: Text(
                    appLocalizations.next,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView secondWidget(
      CompleteProfileProvider completeProfileProvider, BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: secondWidgetFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.companyName,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextFieldForm(
                controller:
                    completeProfileProvider.companyNameTextFieldController,
                onChanged: (nameChanged) => completeProfileProvider
                    .updateCompanyNameTextField(nameChanged),
                keyboardType: TextInputType.text,
                placeholder: appLocalizations.companyName,
                emptyValueText: 'please type your company',
                focus: companyNameFocus,
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                appLocalizations.companyType,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomDropdownTextField(
                placeholder: appLocalizations.companyType,
                controller:
                    completeProfileProvider.companyTypeTextFieldController,
                options: [
                  appLocalizations.public_transportation,
                  appLocalizations.private_transportation,
                  appLocalizations.vip_transportation,
                ],
                onChanged: (nameChanged) => completeProfileProvider
                    .updateCompanyTypeTextField(nameChanged),
                emptyValueText: 'please type company type',
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                appLocalizations.placeOfCompany,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomDropdownTextField(
                placeholder: appLocalizations.placeOfCompany,
                controller:
                    completeProfileProvider.companyPlaceTextFieldController,
                options: [
                  appLocalizations.madinah,
                  appLocalizations.makkah,
                  appLocalizations.jeddah,
                ],
                onChanged: (textChanged) => completeProfileProvider
                    .updateCompanyPlaceTextField(textChanged),
                emptyValueText: 'please type your company place',
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                appLocalizations.companyRegistrationNumber,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextFieldForm(
                leftWidget: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    textAlign: TextAlign.center,
                    "7",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                controller: completeProfileProvider
                    .companyRegistrationNumberTextFieldController,
                onChanged: (textChanged) => completeProfileProvider
                    .updateCompanyRegistrationTextField(textChanged),
                keyboardType: TextInputType.text,
                placeholder: appLocalizations.companyRegistrationNumber,
                emptyValueText: 'please type your Company Registration Number',
                focus: registrationCompanyNumFocus,
                inputFormatters: [LengthLimitingTextInputFormatter(9)],
                minLength: 9,
                minLengthErrorText:
                    'Registration Number must be at least 9 numbers',
              ),
              SizedBox(height: screenHeight * 0.04),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue[900],
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    if (secondWidgetFormKey.currentState!.validate()) {
                      completeProfileProvider.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    }
                  },
                  child: Text(
                    appLocalizations.next,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView thirdsWidget(
      CompleteProfileProvider completeProfileProvider, BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          top: false,
          bottom: true,
          child: Form(
            key: thirdWidgetFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.carType,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomDropdownTextField(
                  placeholder: appLocalizations.carType,
                  controller:
                      completeProfileProvider.carTypeTextFieldController,
                  options: [
                    appLocalizations.innova,
                    appLocalizations.k5,
                    appLocalizations.sonata,
                    appLocalizations.staria,
                    appLocalizations.camry,
                    appLocalizations.fortuner,
                    appLocalizations.expander,
                    appLocalizations.elantra,
                  ],
                  onChanged: (textChanged) => completeProfileProvider
                      .updateCarTypeTextField(textChanged),
                  emptyValueText: 'please choose your car type',
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  appLocalizations.numOfPassengers,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomDropdownTextField(
                  placeholder: appLocalizations.numOfPassengers,
                  controller: completeProfileProvider
                      .numOfPassengersTextFieldController,
                  options: [
                    "4",
                    "5",
                    "6",
                    "7",
                    "8",
                    "9",
                  ],
                  onChanged: (textChanged) => completeProfileProvider
                      .updateNumberOfPassengersTextField(textChanged),
                  emptyValueText: 'please choose number of passengers',
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  appLocalizations.carModel,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomDropdownTextField(
                  placeholder: appLocalizations.numOfPassengers,
                  controller:
                      completeProfileProvider.carModelTextFieldController,
                  options: [
                    "2019",
                    "2020",
                    "2021",
                    "2022",
                    "2023",
                    "2024",
                    "2025",
                    "2026",
                  ],
                  onChanged: (textChanged) => completeProfileProvider
                      .updateCarModelTextField(textChanged),
                  emptyValueText: 'please choose your Car Model',
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  appLocalizations.carColor,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomDropdownTextField(
                  placeholder: appLocalizations.carColor,
                  controller:
                      completeProfileProvider.carColorTextFieldController,
                  options: [
                    appLocalizations.white,
                    appLocalizations.black,
                    appLocalizations.silver,
                    appLocalizations.grey,
                  ],
                  onChanged: (textChanged) => completeProfileProvider
                      .updateCarColorTextField(textChanged),
                  emptyValueText: 'please choose your Car Color',
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  appLocalizations.licenseNumber,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextFieldForm(
                  controller:
                      completeProfileProvider.licenseNumberTextFieldController,
                  onChanged: (textChanged) => completeProfileProvider
                      .updateLicenseTextField(textChanged),
                  keyboardType: TextInputType.text,
                  placeholder:
                      '${appLocalizations.licenseNumber} EX A F R 2091',
                  emptyValueText: 'please type your License Plate Number',
                  focus: licenseFocus,
                ),
                SizedBox(height: screenHeight * 0.04),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue[900],
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      if (thirdWidgetFormKey.currentState!.validate()) {
                        completeProfileProvider.pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => VerifyNumberScreen()),
                      // );
                    },
                    child: Text(
                      appLocalizations.next,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding finalWidgetAttachedFiles(
      CompleteProfileProvider completeProfileProvider, BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.idImage,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[900],
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () async =>
                            await completeProfileProvider.pickIdImage(),
                        child: Text(
                          (completeProfileProvider.idImage == null)
                              ? appLocalizations.pickAnImage
                              : appLocalizations.replaceImage,
                        ),
                      ),
                      (completeProfileProvider.idImage != null)
                          ? Image.file(
                              height: 100,
                              width: 100,
                              completeProfileProvider.idImage ?? File(""))
                          : SizedBox()
                    ],
                  ),
                  Divider(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.carImage,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[900],
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () async =>
                            await completeProfileProvider.pickCarImage(),
                        child: Text(
                          (completeProfileProvider.carImage == null)
                              ? appLocalizations.pickAnImage
                              : appLocalizations.replaceImage,
                        ),
                      ),
                      (completeProfileProvider.carImage != null)
                          ? Image.file(
                              height: 100,
                              width: 100,
                              completeProfileProvider.carImage ?? File(""))
                          : SizedBox()
                    ],
                  ),
                  Divider(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.licenseImage,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[900],
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () async =>
                            await completeProfileProvider.pickLicenseImage(),
                        child: Text(
                          (completeProfileProvider.licenseImage == null)
                              ? appLocalizations.pickAnImage
                              : appLocalizations.replaceImage,
                        ),
                      ),
                      (completeProfileProvider.licenseImage != null)
                          ? Image.file(
                              height: 100,
                              width: 100,
                              completeProfileProvider.licenseImage ?? File(""))
                          : SizedBox()
                    ],
                  ),
                  Divider(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.driverImage,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[900],
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () async =>
                            await completeProfileProvider.pickDriverImage(),
                        child: Text(
                          (completeProfileProvider.driverImage == null)
                              ? appLocalizations.pickAnImage
                              : appLocalizations.replaceImage,
                        ),
                      ),
                      (completeProfileProvider.driverImage != null)
                          ? Image.file(
                              height: 100,
                              width: 100,
                              completeProfileProvider.driverImage ?? File(""))
                          : SizedBox()
                    ],
                  ),
                  Divider(),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  if (completeProfileProvider.idImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                        'please upload your id image!',
                        style: TextStyle(color: Colors.red),
                      )),
                    );
                    return;
                  }
                  if (completeProfileProvider.carImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                        'please upload your car image!',
                        style: TextStyle(color: Colors.red),
                      )),
                    );
                    return;
                  }

                  if (completeProfileProvider.licenseImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                        'please upload your license image!',
                        style: TextStyle(color: Colors.red),
                      )),
                    );
                    return;
                  }

                  if (completeProfileProvider.driverImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                        'please upload your image!',
                        style: TextStyle(color: Colors.red),
                      )),
                    );
                    return;
                  }
                  await completeProfileProvider
                      .completeProfile(context)
                      .then((response) {
                    if (response?.statusCode == 200 ||
                        response?.statusCode == 201) {
                      if (context.mounted) {
                        //  show waiting status
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 6),
                            content: Text(
                              textAlign: TextAlign.start,
                              "Your Data Submitted Successfully.\n Please wait until your account is approved.",
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                        );
                      }
                    }
                  });
                },
                child: Text(
                  style: TextStyle(fontSize: 20),
                  appLocalizations.submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
