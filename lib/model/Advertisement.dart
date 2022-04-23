// To parse this JSON data, do
//
//     final advertismentModel = advertismentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AdvertismentModel advertismentModelFromJson(String str) => AdvertismentModel.fromJson(json.decode(str));

String advertismentModelToJson(AdvertismentModel data) => json.encode(data.toJson());

class AdvertismentModel {
  AdvertismentModel({
    required this.error,
    required this.data,
    required this.msg,
  });

  bool error;
  List<AdvertismentList> data;
  String msg;

  factory AdvertismentModel.fromJson(Map<String, dynamic> json) => AdvertismentModel(
    error: json["error"],
    data: List<AdvertismentList>.from(json["data"].map((x) => AdvertismentList.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class AdvertismentList {
  AdvertismentList({
    required this.the0,
    required this.the1,
    required this.description,
    required this.advImage,
  });

  String the0;
  String the1;
  String description;
  String advImage;

  factory AdvertismentList.fromJson(Map<String, dynamic> json) => AdvertismentList(
    the0: json["0"],
    the1: json["1"],
    description: json["description"],
    advImage: json["adv_image"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "description": description,
    "adv_image": advImage,
  };
}
