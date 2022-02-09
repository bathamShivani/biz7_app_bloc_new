// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.error,
    required this.data,
    required this.msg,
  });

  bool error;
  Data data;
  String msg;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
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
    required this.otp,
  });

  int id;
  int otp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "otp": otp,
  };
}
