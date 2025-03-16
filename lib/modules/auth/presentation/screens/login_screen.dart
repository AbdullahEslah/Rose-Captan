import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rose_captain/core/utils/lang/app_language_provider.dart';
import 'package:rose_captain/modules/auth/presentation/providers/auth_provider.dart';
import 'package:rose_captain/modules/auth/presentation/screens/verify_number_screen.dart';

import '../../../../core/custom_widgets/custom_text_field/text_field_widget.dart';
import '../enums/login_enum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  // static final GlobalKey<FormState> _mobileFormKey = GlobalKey<FormState>();
  final FocusNode dismissFocus = FocusNode();

  Padding gettingProviderWidget(
      AuthProvider authProvider, BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<AppLanguage>(context, listen: false);
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: CustomTextFieldForm(
              textAlign: TextAlign.start,
              focus: dismissFocus,
              keyboardType: TextInputType.phone,
              controller: authProvider.mobileTextFieldController,
              onChanged: (mobileChanged) =>
                  authProvider.updateMobileTextField(mobileChanged),
              leftWidget: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  textAlign: TextAlign.center,
                  "05",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              placeholder: appLocalizations.mobile,
              emptyValueText: 'please add your phone number',
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[900],
                textStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            onPressed: () async {
              await authProvider.loginDriver();
            },
            child: Text(appLocalizations.login),
          )
        ],
      ),
    );
  }

  Widget getCurrentWidget(
      {required BuildContext context, required AuthProvider authProvider}) {
    final state = authProvider.loginState;

    switch (state) {
      case LoginEnum.normal:
        gettingProviderWidget(authProvider, context);
        break;

      case LoginEnum.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black54,
          ),
        );

      case LoginEnum.success:
        print("screen in success state");
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
                'Logged in Successfully!',
                style: TextStyle(color: Colors.green),
              ),
            ),
          );
          // }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerifyNumberScreen()),
          );
          authProvider.resetLoginState();
        });

      //  error
      case LoginEnum.error:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          authProvider.resetLoginState();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                authProvider.errorMessage ?? "",
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        });
    }
    return gettingProviderWidget(authProvider, context);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<AppLanguage>(context);
    final b = OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(color: Colors.black87, width: 2),
    );
    return Scaffold(
      body: GestureDetector(
        onTap: dismissFocus.unfocus,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/Safe_driving_apps.jpg.webp",
                fit: BoxFit.fill,
                height: screenHeight * 0.35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        height: screenHeight * 0.07,
                        child: InputDecorator(
                          isFocused: true,
                          decoration: InputDecoration(
                            border: b,
                            enabledBorder: b,
                            focusedBorder: b,
                          ),
                          child: DropdownButton(
                            onChanged: (value) => languageProvider
                                .changeLanguage(Locale(value ?? "")),
                            value: languageProvider.appLocal
                                .toString(), // change this line with your way to get current locale to select it as default in dropdown
                            items: [
                              const DropdownMenuItem(
                                  value: 'en', child: Text('English')),
                              const DropdownMenuItem(
                                  value: 'ur', child: Text('اردو زبان')),
                              const DropdownMenuItem(
                                  value: 'ar', child: Text('العربية'))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Text(
                      appLocalizations.login,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: screenHeight * 0.001,
                    ),
                    Text(
                      appLocalizations.enterYourMobileNumberToContinue,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: screenHeight * 0.07,
                    ),
                    Text(
                      appLocalizations.yourMobileNumber,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
