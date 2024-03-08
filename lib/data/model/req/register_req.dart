// To parse this JSON data, do
//
//     final registerReq = registerReqFromJson(jsonString);

import 'dart:convert';

RegisterReq registerReqFromJson(String str) =>
    RegisterReq.fromJson(json.decode(str));

String registerReqToJson(RegisterReq data) => json.encode(data.toJson());

class RegisterReq {
  final String email;
  final String phone;
  final String password;
  final String firstname;
  final String lastname;
  final String address;
  final String zipcode;
  final String city;
  final String state;
  final String company;
  final String gender;
  final String dob;

  RegisterReq({
    required this.email,
    required this.phone,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.zipcode,
    required this.city,
    required this.state,
    required this.company,
    required this.gender,
    required this.dob,
  });

  factory RegisterReq.fromJson(Map<String, dynamic> json) => RegisterReq(
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        address: json["address"],
        zipcode: json["zipcode"],
        city: json["city"],
        state: json["state"],
        company: json["company"],
        gender: json["gender"],
        dob: json["dob"],
        // dob: DateTime.parse(json["dob"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
        "address": address,
        "zipcode": zipcode,
        "city": city,
        "state": state,
        "company": company,
        "gender": gender,
        "dob": dob,
      };
}
