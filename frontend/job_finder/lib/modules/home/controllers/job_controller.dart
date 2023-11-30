import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:job_finder/global/config/api/api_configs.dart';
import 'package:job_finder/global/config/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:job_finder/modules/auth/controllers/auth_controller.dart';
import '../../../global/models/job.dart';
import '../../../global/models/login_response.dart';

class JobController {
  // Private constructor
  JobController._();

  

  // Single instance of JobController
  static final JobController _instance = JobController._();

  // Factory method to get the singleton instance
  factory JobController() => _instance;
  final _jobDataController =
      StreamController<Either<String, List<Job>>>.broadcast();
  Stream<Either<String, List<Job>>> get jobsDataStream =>
      _jobDataController.stream;
  List<Job> parseJobs(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    return parsed.map<Job>((json) => Job.fromJson(json)).toList();
  }

  Future<void> fetchAllJobs() async {
    if (!AuthController.isAuthenticated) {
      return _jobDataController.sink.add(left("You are not Authenticated"));
    }
    LoginResponse userData = LoginResponse();
    await LocalStrorageConfig.getUserData().then((value) => userData = value!);
    var response =
        await http.get(Uri.parse(ApiConfig.url + ApiConfig.jobs), headers: {
      "Authorization": "Bearer ${userData.token!}",
    });
    print(jsonDecode(response.body));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      _jobDataController.sink.add(right(parseJobs(response.body)));
    } else {
      _jobDataController.sink.add(left(jsonDecode(response.body)["message"]));
    }
  }

  Future<void> getJobsByUserID() async {
    if (!AuthController.isAuthenticated) {
      return _jobDataController.sink.add(left("You are not Authenticated"));
    }
    else{
      LoginResponse userData = LoginResponse();
    await LocalStrorageConfig.getUserData().then((value) => userData = value!);
    var response =
        await http.get(Uri.parse('${ApiConfig.url + ApiConfig.jobs}by-user?userID=${userData.userId!}'), headers: {
      "Authorization": "Bearer ${userData.token!}",
    });
    print(jsonDecode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _jobDataController.sink.add(right(parseJobs(response.body)));
      } else {
        _jobDataController.sink.add(left(jsonDecode(response.body)["message"]));
      }
    }
  }

  Future<Either<String,Job>> getJobByID(String id) async {
    if (!AuthController.isAuthenticated) {
      return left("You are not Authenticated");
    }
    else{
      LoginResponse userData = LoginResponse();
    await LocalStrorageConfig.getUserData().then((value) => userData = value!);
    var response =
        await http.get(Uri.parse('${ApiConfig.url + ApiConfig.jobs}$id'), headers: {
      "Authorization": "Bearer ${userData.token!}",
    });
    print(jsonDecode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return right(Job.fromJson(jsonDecode(response.body)));
      } else {
        return left(jsonDecode(response.body)["message"]);
      }
    }
  }

}
