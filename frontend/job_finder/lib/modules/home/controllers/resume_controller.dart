import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:job_finder/global/config/api/api_configs.dart';
import 'package:job_finder/global/config/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:job_finder/modules/auth/controllers/auth_controller.dart';

import '../../../global/models/login_response.dart';
import '../../../global/models/resume.dart';



class ResumeController {
  ResumeController._();
  static final ResumeController _instance = ResumeController._();
  factory ResumeController() => _instance;
  final _resumeDataController =
      StreamController<Either<String, Resume>>.broadcast();
  Stream<Either<String, Resume>> get resumeDataStream =>
      _resumeDataController.stream;
  Future<void> fetchResumeByUserID({String? userID}) async {
    if (!AuthController.isAuthenticated) {
      _resumeDataController.sink.add(left("You are not authenticatedle"));
    }
    LoginResponse userData = LoginResponse();
    await LocalStrorageConfig.getUserData().then((value) => userData = value!);
    var response = await http.get(
        Uri.parse(
            "${ApiConfig.url}${ApiConfig.resume}user/${userID ?? userData.userId!}"),
        headers: {
          "Authorization": "Bearer ${userData.token!}",
        });
    print(jsonDecode(response.body));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      _resumeDataController.sink
          .add(right(Resume.fromJson(jsonDecode(response.body))));
    } else {
      _resumeDataController.sink.add(left(response.body));
    }
  }
}
