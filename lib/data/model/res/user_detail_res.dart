// To parse this JSON data, do
//
//     final userDetailRes = userDetailResFromJson(jsonString);

import 'dart:convert';

UserDetailRes userDetailResFromJson(String str) =>
    UserDetailRes.fromJson(json.decode(str));

String userDetailResToJson(UserDetailRes data) => json.encode(data.toJson());

class UserDetailRes {
  final UserData data;

  UserDetailRes({
    required this.data,
  });

  factory UserDetailRes.fromJson(Map<String, dynamic> json) => UserDetailRes(
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class UserData {
  final String id;
  final String firstname;
  final String lastname;
  String gender;
  DateTime dob;
  final String email;
  final String password;
  final String phone;
  final bool isProfileComplete;
  final bool isAddressComplete;
  final bool isCardProvided;
  final bool isPinProvided;
  final bool hasPasswordChanged;
  final String stripeCustomerId;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;
  final String address;
  final String company;
  final String city;
  final String state;
  final String zipcode;

  UserData({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phone,
    required this.isProfileComplete,
    required this.isAddressComplete,
    required this.isCardProvided,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.address,
    required this.city,
    required this.company,
    required this.state,
    required this.zipcode,
    required this.hasPasswordChanged,
    required this.isPinProvided,
    required this.stripeCustomerId,
    required this.dob,
    required this.gender,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"] ?? '',
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        phone: json["phone"] ?? '',
        isAddressComplete: json['isAddressComplete'] ?? true,
        isCardProvided: json['isCardProvided'] ?? true,
        isProfileComplete: json['isProfileComplete'] ?? true,
        role: json["role"] ?? '',
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        v: json["__v"] ?? 0,
        address: json['address'] ?? '',
        city: json['city'] ?? '',
        company: json['company'] ?? '',
        state: json['state'] ?? '',
        zipcode: json['zipcode'] ?? '',
        hasPasswordChanged: json['hasPasswordChanged'] ?? true,
        isPinProvided: json['isPinProvided'] ?? true,
        stripeCustomerId: json['stripe_customer_id'] ?? '',
        dob: json["dob"] == null ? DateTime(2008) : DateTime.parse(json["dob"]),
        // dob: json["dob"] == null ? DateTime.now() : DateTime.parse(json["dob"]),
        gender: json['gender'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        " isAddressComplete": isAddressComplete,
        "isCardProvided": isCardProvided,
        "isProfileComplete": isProfileComplete,
        "phone": phone,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "address": address,
        "city": city,
        "company": company,
        "state": state,
        "zipcode": zipcode,
        "hasPasswordChanged": hasPasswordChanged,
        "isPinProvided": isPinProvided,
        "stripe_customer_id": stripeCustomerId,
        "gender": gender,
        "dob": dob,
      };
}
