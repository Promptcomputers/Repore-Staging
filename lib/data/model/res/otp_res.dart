

// // To parse this JSON data, do
// //
// //     final sendOtpRes = sendOtpResFromJson(jsonString);

// import 'dart:convert';

// SendOtpRes sendOtpResFromJson(String str) =>
//     SendOtpRes.fromJson(json.decode(str));

// String sendOtpResToJson(SendOtpRes data) => json.encode(data.toJson());

// class SendOtpRes {
//   final String? status;
//   final String? message;
//   final OtpData? data;

//   SendOtpRes({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory SendOtpRes.fromJson(Map<String, dynamic> json) => SendOtpRes(
//         status: json["status"],
//         message: json["message"],
//         data: OtpData.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data!.toJson(),
//       };
// }

// class OtpData {
//   final num? otp;
//   final OtpUser? user;

//   OtpData({
//     this.otp,
//     this.user,
//   });

//   factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
//         otp: json["otp"] ?? 0,
//         user: OtpUser.fromJson(json["user"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "otp": otp,
//         "user": user!.toJson(),
//       };
// }

// class OtpUser {
//   final String id;
//   final String firstname;
//   final String lastname;
//   final String address;
//   final String city;
//   final String state;
//   final String zipcode;
//   final String email;
//   final String password;
//   final String phone;
//   final String role;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final num v;
//   final String company;
//   final dynamic otpReference;

//   OtpUser({
//     required this.id,
//     required this.firstname,
//     required this.lastname,
//     required this.address,
//     required this.city,
//     required this.state,
//     required this.zipcode,
//     required this.email,
//     required this.password,
//     required this.phone,
//     required this.role,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.company,
//     this.otpReference,
//   });

//   factory OtpUser.fromJson(Map<String, dynamic> json) => OtpUser(
//         id: json["_id"] ?? '',
//         firstname: json["firstname"] ?? '',
//         lastname: json["lastname"] ?? '',
//         address: json["address"] ?? '',
//         city: json["city"] ?? '',
//         state: json["state"] ?? '',
//         zipcode: json["zipcode"] ?? '',
//         email: json["email"] ?? '',
//         password: json["password"] ?? '',
//         phone: json["phone"] ?? '',
//         role: json["role"] ?? '',
//         createdAt: json["created_at"] == null
//             ? DateTime.now()
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? DateTime.now()
//             : DateTime.parse(json["updated_at"]),
//         v: json["__v"] ?? 0,
//         company: json["company"] ?? '',
//         otpReference: json["otp_reference"] ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "firstname": firstname,
//         "lastname": lastname,
//         "address": address,
//         "city": city,
//         "state": state,
//         "zipcode": zipcode,
//         "email": email,
//         "password": password,
//         "phone": phone,
//         "role": role,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "__v": v,
//         "company": company,
//         "otp_reference": otpReference,
//       };
// }
