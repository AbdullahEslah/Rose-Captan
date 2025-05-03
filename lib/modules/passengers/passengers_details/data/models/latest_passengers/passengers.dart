// To parse this JSON data, do
//
//     final passengers = passengersFromJson(jsonString);

import 'dart:convert';

Passengers passengersFromJson(String str) =>
    Passengers.fromJson(json.decode(str));

String passengersToJson(Passengers data) => json.encode(data.toJson());

class Passengers {
  bool? success;
  String? message;
  List<AllPassengers>? data;

  Passengers({
    this.success,
    this.message,
    this.data,
  });

  factory Passengers.fromJson(Map<String, dynamic> json) => Passengers(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AllPassengers>.from(
                json["data"]!.map((x) => AllPassengers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AllPassengers {
  int? id;
  String? from;
  String? to;
  String? count;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<PassengersInfo>? list;

  AllPassengers({
    this.id,
    this.from,
    this.to,
    this.count,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.list,
  });

  factory AllPassengers.fromJson(Map<String, dynamic> json) => AllPassengers(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        count: json["count"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        list: json["list"] == null
            ? []
            : List<PassengersInfo>.from(
                json["list"]!.map((x) => PassengersInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "count": count,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class PassengersInfo {
  int? id;
  String? name;
  String? idNumber;
  String? gender;
  String? phoneNumber;
  int? passengerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  PassengersInfo({
    this.id,
    this.name,
    this.idNumber,
    this.gender,
    this.phoneNumber,
    this.passengerId,
    this.createdAt,
    this.updatedAt,
  });

  factory PassengersInfo.fromJson(Map<String, dynamic> json) => PassengersInfo(
        id: json["id"],
        name: json["name"],
        idNumber: json["id_number"],
        gender: json["Gender"],
        phoneNumber: json["Phone_number"],
        passengerId: json["passenger_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "id_number": idNumber,
        "Gender": gender,
        "Phone_number": phoneNumber,
        "passenger_id": passengerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
