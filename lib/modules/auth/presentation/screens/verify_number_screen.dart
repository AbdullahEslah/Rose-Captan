import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../core/custom_widgets/custom_text_field/text_field_widget.dart';
import '../enums/verify_number_enum.dart';
import '../providers/auth_provider.dart';
import 'complete_driver_profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyNumberScreen extends StatelessWidget {
  VerifyNumberScreen({super.key});
  static final GlobalKey<FormState> _verifyNumberFormKey =
      GlobalKey<FormState>();
  final FocusNode dismissFocus = FocusNode();

  Padding gettingProviderWidget(
      AuthProvider authProvider, BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          CustomTextFieldForm(
            controller: authProvider.verifyNumberTextFieldController,
            onChanged: (mobileChanged) =>
                authProvider.updateVerifyNumberTextField(mobileChanged),
            keyboardType: TextInputType.number,
            placeholder: appLocalizations.code,
            emptyValueText: 'please type code',
            focus: dismissFocus,
          ),
          // SizedBox(height: screenHeight * 0.03),
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                  onPressed: () async => await authProvider.resendCodeOTP(),
                  child: Text(
                    appLocalizations.resendCode,
                    style: TextStyle(color: Colors.black87),
                  ))),
          SizedBox(height: screenHeight * 0.03),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[900],
                textStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            onPressed: () async => await authProvider.verifyDriverLoginOTP(),
            child: Text(
              appLocalizations.verify,
            ),
          )
        ],
      ),
    );
  }

  Widget getCurrentWidget(
      {required BuildContext context, required AuthProvider authProvider}) {
    final state = authProvider.verifyState;

    switch (state) {
      case VerifyNumberEnum.normal:
        gettingProviderWidget(authProvider, context);
        break;

      case VerifyNumberEnum.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black54,
          ),
        );

      case VerifyNumberEnum.success:
        print("verification code screen in success state");
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
              'Verified Successfully!',
              style: TextStyle(color: Colors.green),
            )),
          );
          // }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompleteDriverProfileScreen()),
          );
          authProvider.resetVerifyState();
        });

      //  error
      case VerifyNumberEnum.error:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                authProvider.errorMessage ?? "",
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
          authProvider.resetVerifyState();
        });
    }
    return gettingProviderWidget(authProvider, context);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: GestureDetector(
        onTap: dismissFocus.unfocus,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(alignment: AlignmentDirectional.topStart, children: [
              Image.asset(
                "assets/images/cover_auth_image.png",
                fit: BoxFit.fill,
                height: screenHeight * 0.35,
              ),
              SafeArea(
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
                        Navigator.pop(context);
                      },
                      child: Icon(
                        color: Colors.white,
                        appLocalizations.localeName == "en"
                            ? CupertinoIcons.arrow_left_circle_fill
                            : CupertinoIcons.arrow_right_circle_fill,
                        size: 30,
                      )),
                ),
              ),
              SafeArea(
                  child: Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Text(
                        appLocalizations.otpVerification,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ))),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.weHaveSentACodeToYourMobileToLogin,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: screenHeight * 0.07,
                    ),
                    Text(
                      appLocalizations.enterCode,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return getCurrentWidget(
                            context: context, authProvider: authProvider);
                      },
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
