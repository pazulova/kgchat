import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _localStorage;
  static SharedPreferences? _preferences;

  static Future<LocalStorage> initLocalStorage() async {
    if (_localStorage == null) {
      final secureStorage = LocalStorage._();
      await secureStorage._init();
      _localStorage = secureStorage;
    }
    return _localStorage!;
  }

  LocalStorage._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String? getString(String key) {
    return _preferences!.getString(key);
  }

  // put string
  static Future<bool>? setString(String key, String value) {
    return _preferences!.setString(key, value);
  }

  // clear string
  static Future<bool>? remove(String key) {
    return _preferences!.remove(key);
  }

  // clear string
  static Future<bool>? clear() {
    return _preferences!.clear();
  }

  // get bool
  static bool? getBool(String key) {
    return _preferences!.getBool(key);
  }

  // put bool
  static Future<bool>? setBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }
}
