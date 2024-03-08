// To parse this JSON data, do
//
//     final loginRes = loginResFromJson(jsonString);

import 'dart:convert';

LoginRes loginResFromJson(String str) => LoginRes.fromJson(json.decode(str));

String loginResToJson(LoginRes data) => json.encode(data.toJson());

class LoginRes {
  final String? status;
  final String? message;
  final Data? data;

  LoginRes({
    this.status,
    this.message,
    this.data,
  });

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
        status: json["status"] ?? '',
        message: json["message"] ?? "",
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  final String token;
  final User user;

  Data({
    required this.token,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  final String firstname;
  final String id;
  final String email;
  final String role;

  User({
    required this.firstname,
    required this.id,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstname: json["firstname"] ?? '',
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        role: json["role"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "id": id,
        "email": email,
        "role": role,
      };
}
