import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:rose_captain/core/utils/lang/app_language_provider.dart';
import 'package:rose_captain/modules/auth/data/datasources/user_remote_datasource.dart';
import 'package:rose_captain/modules/auth/data/repositories/user_repository_impl.dart';
import 'package:rose_captain/modules/auth/domain/usecases/complete_profile_usecase.dart';
import 'package:rose_captain/modules/auth/domain/usecases/driver_login_usecase.dart';
import 'package:rose_captain/modules/auth/domain/usecases/driver_verify_login_usecase.dart';
import 'package:rose_captain/modules/auth/domain/usecases/resend_verification_code_usecase.dart';
import 'package:rose_captain/modules/auth/presentation/providers/auth_provider.dart';
import 'package:rose_captain/modules/auth/presentation/providers/complete_profile_provider.dart';

import 'modules/auth/presentation/screens/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appLanguage = AppLanguage();
  await appLanguage.loadLanguage(); // تحميل اللغة عند البدء
  runApp(ChangeNotifierProvider(
      create: (context) => appLanguage, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //  language provider
          // ),
          //  Authentication Provider
          ChangeNotifierProvider(
            create: (context) => AuthProvider(
              DriverLoginUseCase(
                UserRepositoryImpl(
                  UserRemoteDatasourceImpl(Client()),
                ),
              ),
              DriverVerifyLoginUseCase(
                UserRepositoryImpl(
                  UserRemoteDatasourceImpl(Client()),
                ),
              ),
              ResendVerificationCodeUsecase(
                UserRepositoryImpl(
                  UserRemoteDatasourceImpl(Client()),
                ),
              ),
            ),
          ),
          //  CompleteProfileProvider
          ChangeNotifierProvider(
            create: (context) => CompleteProfileProvider(
              CompleteProfileUsecase(
                UserRepositoryImpl(
                  UserRemoteDatasourceImpl(Client()),
                ),
              ),
            ),
          )
        ],
        child:
            Consumer<AppLanguage>(builder: (context, languageProvider, child) {
          return MaterialApp(
              locale: languageProvider.appLocal,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                // Localizes material widgets like dialogs, buttons, and tooltips.
                GlobalWidgetsLocalizations.delegate,
                // Supports text direction (RTL & LTR).
                GlobalCupertinoLocalizations.delegate,
                // For iOS widgets localization
              ],
              supportedLocales: [
                Locale('en', 'IR'), // English
                Locale('ur', 'IR'), // undo
                Locale('ar', 'EG') // شق
                // Add more locales as needed
              ],
              debugShowCheckedModeBanner: false,
              title: 'Rose Captan',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // TRY THIS: Try running your application with "flutter run". You'll see
                // the application has a purple toolbar. Then, without quitting the app,
                // try changing the seedColor in the colorScheme below to Colors.green
                // and then invoke "hot reload" (save your changes or press the "hot
                // reload" button in a Flutter-supported IDE, or press "r" if you used
                // the command line to start the app).
                //
                // Notice that the counter didn't reset back to zero; the application
                // state is not lost during the reload. To reset the state, use hot
                // restart instead.
                //
                // This works for code too, not just values: Most code changes can be
                // tested with just a hot reload.
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

                useMaterial3: true,
              ),
              home: LoginScreen());
        }));
    // );
  }
}
