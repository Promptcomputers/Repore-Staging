// To parse this JSON data, do
//
//     final createTicketRes = createTicketResFromJson(jsonString);

import 'dart:convert';

CreateTicketRes createTicketResFromJson(String str) =>
    CreateTicketRes.fromJson(json.decode(str));

String createTicketResToJson(CreateTicketRes data) =>
    json.encode(data.toJson());

class CreateTicketRes {
  final TicketData? data;

  CreateTicketRes({
    this.data,
  });

  factory CreateTicketRes.fromJson(Map<String, dynamic> json) =>
      CreateTicketRes(
        data: TicketData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class TicketData {
  final CreateTicket ticket;

  TicketData({
    required this.ticket,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) => TicketData(
        ticket: CreateTicket.fromJson(json["ticket"]),
      );

  Map<String, dynamic> toJson() => {
        "ticket": ticket.toJson(),
      };
}

class CreateTicket {
  final String reference;
  final String type;
  final String subject;
  final String author;
  final String customer;
  final String status;

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;

  CreateTicket({
    required this.reference,
    required this.type,
    required this.subject,
    required this.author,
    required this.customer,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CreateTicket.fromJson(Map<String, dynamic> json) => CreateTicket(
        reference: json["reference"] ?? '',
        type: json["type"] ?? '',
        subject: json["subject"] ?? '',
        author: json["author"] ?? '',
        customer: json["customer"] ?? '',
        status: json["status"] ?? '',
        id: json["_id"] ?? '',
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "type": type,
        "subject": subject,
        "author": author,
        "customer": customer,
        "status": status,
        "_id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}



// // To parse this JSON data, do
// //
// //     final createTicketRes = createTicketResFromJson(jsonString);

// import 'dart:convert';

// CreateTicketRes createTicketResFromJson(String str) =>
//     CreateTicketRes.fromJson(json.decode(str));

// String createTicketResToJson(CreateTicketRes data) =>
//     json.encode(data.toJson());

// class CreateTicketRes {
//   final TicketData? data;

//   CreateTicketRes({
//     this.data,
//   });

//   factory CreateTicketRes.fromJson(Map<String, dynamic> json) =>
//       CreateTicketRes(
//         data: TicketData.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data!.toJson(),
//       };
// }

// class TicketData {
//   final CreateTicket ticket;
//   final List<TicketFileElement> files;

//   TicketData({
//     required this.ticket,
//     required this.files,
//   });

//   factory TicketData.fromJson(Map<String, dynamic> json) => TicketData(
//         ticket: CreateTicket.fromJson(json["ticket"]),
//         files: List<TicketFileElement>.from(
//             json["files"].map((x) => TicketFileElement.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "ticket": ticket.toJson(),
//         "files": List<dynamic>.from(files.map((x) => x.toJson())),
//       };
// }

// class TicketFileElement {
//   final String fieldname;
//   final String originalname;
//   final String encoding;
//   final String mimetype;
//   final int size;
//   final String bucket;
//   final String key;
//   final String acl;
//   final String contentType;
//   final dynamic contentDisposition;
//   final String storageClass;
//   final dynamic serverSideEncryption;
//   final Metadata metadata;
//   final String location;
//   final String etag;

//   TicketFileElement({
//     required this.fieldname,
//     required this.originalname,
//     required this.encoding,
//     required this.mimetype,
//     required this.size,
//     required this.bucket,
//     required this.key,
//     required this.acl,
//     required this.contentType,
//     this.contentDisposition,
//     required this.storageClass,
//     this.serverSideEncryption,
//     required this.metadata,
//     required this.location,
//     required this.etag,
//   });

//   factory TicketFileElement.fromJson(Map<String, dynamic> json) =>
//       TicketFileElement(
//         fieldname: json["fieldname"],
//         originalname: json["originalname"],
//         encoding: json["encoding"],
//         mimetype: json["mimetype"],
//         size: json["size"],
//         bucket: json["bucket"],
//         key: json["key"],
//         acl: json["acl"],
//         contentType: json["contentType"],
//         contentDisposition: json["contentDisposition"],
//         storageClass: json["storageClass"],
//         serverSideEncryption: json["serverSideEncryption"],
//         metadata: Metadata.fromJson(json["metadata"]),
//         location: json["location"],
//         etag: json["etag"],
//       );

//   Map<String, dynamic> toJson() => {
//         "fieldname": fieldname,
//         "originalname": originalname,
//         "encoding": encoding,
//         "mimetype": mimetype,
//         "size": size,
//         "bucket": bucket,
//         "key": key,
//         "acl": acl,
//         "contentType": contentType,
//         "contentDisposition": contentDisposition,
//         "storageClass": storageClass,
//         "serverSideEncryption": serverSideEncryption,
//         "metadata": metadata.toJson(),
//         "location": location,
//         "etag": etag,
//       };
// }

// class Metadata {
//   final String fieldName;

//   Metadata({
//     required this.fieldName,
//   });

//   factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
//         fieldName: json["fieldName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "fieldName": fieldName,
//       };
// }

// class CreateTicket {
//   final String reference;
//   final String type;
//   final String subject;
//   final String author;
//   final String customer;
//   final String status;
//   final String description;
//   final String id;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   CreateTicket({
//     required this.reference,
//     required this.type,
//     required this.subject,
//     required this.author,
//     required this.customer,
//     required this.status,
//     required this.description,
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory CreateTicket.fromJson(Map<String, dynamic> json) => CreateTicket(
//         reference: json["reference"],
//         type: json["type"],
//         subject: json["subject"],
//         author: json["author"],
//         customer: json["customer"],
//         status: json["status"],
//         description: json["description"],
//         id: json["_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "reference": reference,
//         "type": type,
//         "subject": subject,
//         "author": author,
//         "customer": customer,
//         "status": status,
//         "description": description,
//         "_id": id,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }
