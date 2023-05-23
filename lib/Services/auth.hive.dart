import 'package:frontend/Models/token.adapter.dart';
import 'package:frontend/Models/user.adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthHiveClient {
  final _authBox = Hive.box("authBox");
  final _userBox = Hive.box("userBox");

  Future getUser(String key) async {
    return await _userBox.get(key);
  }

  Future<void> storeUserData(UserDataAdapter user) async {
    await _userBox.clear();
    await _userBox.put("user", user);
  }

  Future<void> authHiveStoreToken(TokenModel logginData) async {
    await _authBox.clear();
    await _authBox.put("isLoggedIn", logginData.isLoggedIn);
    await _authBox.put("token", logginData.token);
  }

  Future<String> getToken() async {
    final token = await _authBox.get("token");
    return token;
  }

  Future<void> Logout() async {
    await _authBox.put("token", "");
    await _authBox.put("isLoggedIn", false);
  }
}
