
import 'job.dart';
import 'user.dart';

class Application {
  String? id;
  Application? application;
  Job? job;
  User? applicant;
  User? publisher;

  Application(
      {this.id, this.application, this.job, this.applicant, this.publisher});

  Application.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    application = json['application'] != null
        ? Application.fromJson(json['application'])
        : null;
    job = json['job'] != null ? Job.fromJson(json['job']) : null;
    applicant =
        json['applicant'] != null ? User.fromJson(json['applicant']) : null;
    publisher =
        json['publisher'] != null ? User.fromJson(json['publisher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (application != null) {
      data['application'] = application!.toJson();
    }
    if (job != null) {
      data['job'] = job!.toJson();
    }
    if (applicant != null) {
      data['applicant'] = applicant!.toJson();
    }
    if (publisher != null) {
      data['publisher'] = publisher!.toJson();
    }
    return data;
  }
}
