import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');
  Locale get appLocal => _appLocale;

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code');
    _appLocale = (languageCode != null) ? Locale(languageCode) : Locale('en');
    notifyListeners();
  }

  Future<void> changeLanguage(Locale type) async {
    if (!supportedLocales.contains(type)) return;
    _appLocale = type;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', type.languageCode);

    // إعادة تحميل للغة بشكل قسري
    //WidgetsBinding.instance.performReassemble();
  }

  static List<Locale> supportedLocales = [
    Locale('en', ''),
    Locale('ur', ''),
    Locale('ar', '')
  ];
}
