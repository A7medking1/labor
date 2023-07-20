import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

String stringLang(String text, String textAr) {
  final lang = sl<AppPreferences>().getAppLang();
  if (lang == 'en') {
    return text;
  } else {
    return textAr;
  }
}