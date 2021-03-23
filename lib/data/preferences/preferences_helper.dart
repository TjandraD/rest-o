import 'package:shared_preferences/shared_preferences.dart';

const DAILY_NOTIFICATION = 'DAILY_NOTIFICATION';

class SharedPreferencesHelper {
  static SharedPreferences _sharedPreferences;

  Future<bool> setTimer(String key, bool value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setBool(key, value);
  }

  Future<bool> getTimer(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(key);
  }
}
