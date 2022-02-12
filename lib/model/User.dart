// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.error,
    required this.data,
    required this.msg,
  });

  bool error;
  Data data;
  String msg;

  factory User.fromJson(Map<String, dynamic> json) => User(
    error: json["error"],
    data: Data.fromJson(json["data"]),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": data.toJson(),
    "msg": msg,
  };
}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.email,
    required this.phone,
    required this.address,
    required this.profileImage,
    required this.createdDate,
  });

  int id;
  String firstName;
  String lastName;
  String dob;
  String gender;
  String email;
  String phone;
  String address;
  String profileImage;
  DateTime createdDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"]==null?'':json["first_name"],
    lastName: json["last_name"]==null?'':json["last_name"],
    dob: json["dob"],
    gender: json["gender"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    profileImage: json["profile_image"],
    createdDate: DateTime.parse(json["created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "dob": dob,
    "gender": gender,
    "email": email,
    "phone": phone,
    "address": address,
    "profile_image": profileImage,
    "created_date": createdDate.toIso8601String(),
  };
}
