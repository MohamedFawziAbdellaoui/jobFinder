import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:job_finder/global/config/api/api_configs.dart';
import 'package:job_finder/global/models/login_response.dart';

class AuthController {
  static bool isAuthenticated = false;

  // Method to set the authentication status
  static void setAuthenticationStatus(bool status) {
    isAuthenticated = status;
  }

  static String loginUrl = ApiConfig.url + ApiConfig.auth + ApiConfig.login;
  static String signupUrl = ApiConfig.url + ApiConfig.auth + ApiConfig.signUp;

  static Future<Either<String, LoginResponse>> loginUser(
    String email,
    String password,
  ) async {
    final url = Uri.parse(loginUrl);
    final Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      url,
      body: body,
    );
    print(jsonDecode(response.body));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      setAuthenticationStatus(true);
      return right(LoginResponse.fromJson(jsonDecode(response.body)));
    } else {
      return left(response.body);
    }
  }
}
