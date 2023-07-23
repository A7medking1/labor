import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:labour/src/app/data/model/location_model.dart';
import 'package:labour/src/core/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsOnBoarding = 'onBoarding';
const String prefsOnBoardingLang = 'onBoardingLang';
const String token = 'token';
const String language = 'language';
const String currentLocation = 'currentLocation';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  /// onBoarding
  Future<void> setOnBoarding() async {
    await _sharedPreferences.setBool(prefsOnBoarding, true);
  }

  bool isOnBoardingInPrefs() {
    return _sharedPreferences.getBool(prefsOnBoarding) ?? false;
  }

  Future<bool> removeOnBoarding() async {
    return await _sharedPreferences.remove(prefsOnBoarding);
  }

  /// onBoarding Language
  Future<void> setOnBoardingLang() async {
    await _sharedPreferences.setBool(prefsOnBoardingLang, true);
  }

  bool isOnBoardingLangInPrefs() {
    return _sharedPreferences.getBool(prefsOnBoardingLang) ?? false;
  }

  Future<bool> removeOnBoardingLang() async {
    return await _sharedPreferences.remove(prefsOnBoardingLang);
  }

  /// user
  Future<void> setUserToken(String userToken) async {
    await _sharedPreferences.setString(token, userToken);
  }

  String getUserToken() {
    print(_sharedPreferences.getString(token));
    return _sharedPreferences.getString(token) ?? '';
  }

  bool isUserLoggedIn() {
    return _sharedPreferences.containsKey(token);
  }

  Future<bool> removeUserToken() async {
    return await _sharedPreferences.remove(token);
  }

  // current location
  Future<void> setLocation(LocationsModel locationsModel) async {
    await _sharedPreferences.setString(
        currentLocation, jsonEncode(locationsModel.toJson()));
  }

  LocationsModel getLocation() {
    String? userPref = _sharedPreferences.getString(currentLocation);

    if (userPref == null) {
      return LocationsModel.fromJson(noneLocation);
    }

    Map<String, dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    return LocationsModel.fromJson(userMap);
  }

  Future<bool> removeLocation() async {
    return await _sharedPreferences.remove(currentLocation);
  }

  /// language

  String getAppLang() {
    String? lang = _sharedPreferences.getString(language);

    if (lang != null && lang.isNotEmpty) {
      return lang;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> changeAppLang() async {
    String currentLang = getAppLang();

    if (currentLang == LanguageType.arabic.getValue()) {
      await _sharedPreferences.setString(
          language, LanguageType.english.getValue());
    } else {
      await _sharedPreferences.setString(
          language, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLang = getAppLang();
    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocal;
    } else {
      return englishLocal;
    }
  }
}

Map<String, dynamic> noneLocation = {
  'city': '',
  'building': '',
  'street': '',
  'region': '',
};
