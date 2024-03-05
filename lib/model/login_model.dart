import 'dart:convert';

class LoginModel {
  static const String storage_key = 'LoginModel';
  static const String encrypt_key = "bewemp2020";

  String? host;
  String username;
  String password;
  bool? isReadPrivacyPolicy;
  bool? rememberPassword;

  LoginModel({
    this.host,
    required this.username,
    required this.password,
    this.isReadPrivacyPolicy,
    this.rememberPassword,
  });

  bool isEqualTo(LoginModel value) {
    bool equal = host == value.host && username == value.username;
    return equal;
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      host: json['host'],
      username: json['username'],
      password: json['password'],
      isReadPrivacyPolicy: json['isReadPrivacyPolicy'],
      rememberPassword: json['rememberPassword'],
    );
  }

  Map<String, dynamic> toJson() => {
        'host': host,
        'username': username,
        'password': password,
        'isReadPrivacyPolicy': isReadPrivacyPolicy,
        'rememberPassword': rememberPassword,
      };

  @override
  String toString() {
    Map<String, dynamic> map = toJson();
    return json.encode(map);
  }
}
