// To parse this JSON data, do
//
//     final serviceTypeRes = serviceTypeResFromJson(jsonString);

import 'dart:convert';

ServiceTypeRes serviceTypeResFromJson(String str) =>
    ServiceTypeRes.fromJson(json.decode(str));

String serviceTypeResToJson(ServiceTypeRes data) => json.encode(data.toJson());

class ServiceTypeRes {
  final List<ServiceTypeDatum> data;

  ServiceTypeRes({
    required this.data,
  });

  factory ServiceTypeRes.fromJson(Map<String, dynamic> json) => ServiceTypeRes(
        data: List<ServiceTypeDatum>.from(
            json["data"].map((x) => ServiceTypeDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ServiceTypeDatum {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceTypeDatum({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceTypeDatum.fromJson(Map<String, dynamic> json) =>
      ServiceTypeDatum(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
