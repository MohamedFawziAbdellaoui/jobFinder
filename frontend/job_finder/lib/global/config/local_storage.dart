import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/login_response.dart';

class LocalStrorageConfig {
  LocalStrorageConfig._();
  static FlutterSecureStorage storage = FlutterSecureStorage();
  static Future<void> saveUserData(LoginResponse loginResponse) async {
    await storage.write(key: 'token', value: loginResponse.token);
    await storage.write(key: 'userId', value: loginResponse.userId);
  }

  static Future<LoginResponse?> getUserData() async {
    final token = await storage.read(key: 'token');
    final userID = await storage.read(key: 'userId');

    if (token != null && userID != null) {
      return LoginResponse(token: token, userId: userID);
    }

    return null;
  }
}
