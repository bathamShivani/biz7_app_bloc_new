// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    required this.error,
    required this.data,
    required this.msg,
  });

  bool error;
  List<Data> data;
  String msg;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    error: json["error"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class Data {
  Data({
    required this.catId,
    required this.catName,
  });

  int catId;
  String catName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    catId: json["cat_id"],
    catName: json["cat_name"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
  };
}
