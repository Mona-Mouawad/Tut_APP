
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/presentation/resources/langauge_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED = "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";

class AppPreferences
{
final  SharedPreferences _preferences ;

AppPreferences (this._preferences);

Future<String>  getAppLanguage() async
{
  String? language =_preferences.getString(PREFS_KEY_LANG);
  if (language != null && language.isNotEmpty) {
    return language;
  } else {
    // return default lang
   return LanguageType.ENGLISH.getLanguage();
  }
}

Future<void> setUserLoggedIn ()async
{
  _preferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
}

Future<bool> getUserLoggedIn ()async
{
return  _preferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false ;
}

Future<void> setOnBoardingScreenViewed ()async
{
  _preferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true) ;
}

Future<bool> getOnBoardingScreenViewed ()async
{
 return _preferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ?? false ;
}

}