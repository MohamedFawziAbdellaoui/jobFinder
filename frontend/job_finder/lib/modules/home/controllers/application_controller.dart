import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:job_finder/global/config/api/api_configs.dart';
import 'package:job_finder/global/config/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:job_finder/modules/auth/controllers/auth_controller.dart';
import '../../../global/models/application.dart';
import '../../../global/models/login_response.dart';

class ApplicationController {
  // Private constructor
  ApplicationController._();

  // Single instance of ApplicationController
  static final ApplicationController _instance = ApplicationController._();

  // Factory method to get the singleton instance
  factory ApplicationController() => _instance;
  final _applicationDataController =
      StreamController<Either<String, List<Application>>>.broadcast();
  Stream<Either<String, List<Application>>> get appliactionsDataStream =>
      _applicationDataController.stream;
  List<Application> parseApps(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    return parsed
        .map<Application>((json) => Application.fromJson(json))
        .toList();
  }

  Future<void> fetchAllAppsByUser() async {
    if (!AuthController.isAuthenticated) {
      return _applicationDataController.sink
          .add(left("You are not Authenticated"));
    }
    LoginResponse userData = LoginResponse();
    await LocalStrorageConfig.getUserData().then((value) => userData = value!);
    var response = await http.get(
        Uri.parse(
            "${ApiConfig.url + ApiConfig.applications}byApplicant/${userData.userId}"),
        headers: {
          "Authorization": "Bearer ${userData.token!}",
        });
    print(jsonDecode(response.body));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      _applicationDataController.sink.add(right(parseApps(response.body)));
    } else {
      _applicationDataController.sink
          .add(left(jsonDecode(response.body)["message"]));
    }
  }

  Future<String> applyForJob(
      {required String jobId, required String comId}) async {
    if (!AuthController.isAuthenticated) {
      return "You are not Authenticated";
    }
    LoginResponse userData = LoginResponse();
    await LocalStrorageConfig.getUserData().then((value) => userData = value!);
    var response =
        await http.post(Uri.parse("${ApiConfig.url + ApiConfig.applications}"),
            headers: {
              "Authorization": "Bearer ${userData.token!}",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "job_id": jobId,
              "user_id": userData.userId,
              "entreprise_id": comId,
              "status": "pending"
            }));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return "Success";
    } else {
      return jsonDecode(response.body)["message"];
    }
  }
}
