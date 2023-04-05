import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? _preferences;

  LocalStorage([this._preferences]);

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    _verifyInitAssert();
    return _preferences!.getString(key);
  }

  Future<void> setString(String key, String value) {
    _verifyInitAssert();
    return _preferences!.setString(key, value);
  }

  void _verifyInitAssert() {
    assert(_preferences != null, 'init() was not called');
  }
}

class LocalStorageKeys {
  static const userLoginStorageKey = 'user_login';
}

final localStorage = LocalStorage();
