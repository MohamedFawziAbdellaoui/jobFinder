import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:job_finder/global/config/api/api_configs.dart';
import 'package:job_finder/global/config/local_storage.dart';
import 'package:job_finder/global/models/login_response.dart';
import 'package:job_finder/modules/auth/controllers/auth_controller.dart';
import '../../../global/models/user.dart';
import 'package:http/http.dart' as http;

  class UserController {
    static final _userDataController = StreamController<Either<String, User>>();
    static Stream<Either<String, User>> get userDataStream =>
        _userDataController.stream;
    static Future<void> fetchUserData() async {
      if(!AuthController.isAuthenticated){
        _userDataController.sink.add(left("You are not Authenticated"));
      }
      LoginResponse userData = LoginResponse();
      await LocalStrorageConfig.getUserData().then((value) => userData = value!);
      var response =
          await http.get(Uri.parse(ApiConfig.url + ApiConfig.auth + userData.userId!), headers: {
        "Authorization": "Bearer ${userData.token!}",
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _userDataController.sink
            .add(right(User.fromJson(jsonDecode(response.body))));
      } else {
        _userDataController.sink.add(left(response.body));
      }
    }
    static void dispose() {
      _userDataController.close();
    }
  }
