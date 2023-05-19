
import 'package:frontend/Models/user.adapter.dart';
import 'package:hive/hive.dart';

class AuthHiveClient{
  final _authBox = Hive.box("authBox");
  final _userBox = Hive.box("userBox");

  Future getUser(String key) async {
    return await _userBox.get(key);
  }
  Future<void> storeUserData(UserDataAdapter user) async {
    await _userBox.clear();
    await _userBox.put("user", user);
  }
  Future<void> authHiveStoreToken (String token) async {
    await _authBox.clear();
    await _authBox.put("isLoggedIn", true);
    await _authBox.put("token", token);
  }
}