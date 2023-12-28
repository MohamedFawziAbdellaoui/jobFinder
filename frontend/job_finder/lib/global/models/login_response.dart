class LoginResponse {
  String? token;
  String? userId;
  String? userType;

  LoginResponse({this.token, this.userId, this.userType});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    userType = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userId'] = userId;
    data['type'] = userType;
    return data;
  }
}
