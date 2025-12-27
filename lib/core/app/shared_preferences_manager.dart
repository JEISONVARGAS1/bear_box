import 'package:bearbox/core/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  SharedPreferences? _prefs;

  static final SharedPreferenceManager _instance =
      SharedPreferenceManager._internal();

  factory SharedPreferenceManager() {
    return _instance;
  }

  SharedPreferenceManager._internal();

  Future<void> initSharedPreference() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      // Error initializing SharedPreferences: $e
      _prefs = null;
    }
  }

  Future<void> setEmailAccount(String email) async {
    try {
      if (_prefs != null) {
        await _prefs!.setString(AppConstants.hiveConstantsUser, email);
      }
    } catch (e) {
      // Error setting email account: $e
    }
  }

  Future<void> clearEmailAccount() async {
    try {
      if (_prefs != null) {
        await _prefs!.remove(AppConstants.hiveConstantsUser);
      }
    } catch (e) {
      // Error clearing email account: $e
    }
  }

  String getEmailAccount() {
    try {
      if (_prefs != null) {
        final email = _prefs!.getString(AppConstants.hiveConstantsUser);
        if (email != null) return email;
      }
      return "";
    } catch (e) {
      // Error getting email account: $e
      return "";
    }
  }
}
