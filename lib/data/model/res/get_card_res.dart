// To parse this JSON data, do
//
//     final getCards = getCardsFromJson(jsonString);

import 'dart:convert';

List<GetCards> getCardsFromJson(List<dynamic> str) =>
    List<GetCards>.from(str.map((x) => GetCards.fromJson(x)));

String getCardsToJson(List<GetCards> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCards {
  String id;
  String lastDigits;
  String expireDate;
  String type;

  GetCards({
    required this.id,
    required this.lastDigits,
    required this.expireDate,
    required this.type,
  });

  factory GetCards.fromJson(Map<String, dynamic> json) => GetCards(
        id: json["_id"] ?? '',
        lastDigits: json["last_digits"] ?? '',
        expireDate: json["expire_date"] ?? '',
        type: json["type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "last_digits": lastDigits,
        "expire_date": expireDate,
        "type": type,
      };
}
