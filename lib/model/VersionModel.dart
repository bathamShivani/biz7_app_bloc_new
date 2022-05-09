// To parse this JSON data, do
//
//     final versionModel = versionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VersionModel versionModelFromJson(String str) => VersionModel.fromJson(json.decode(str));

String versionModelToJson(VersionModel data) => json.encode(data.toJson());

class VersionModel {
  VersionModel({
    required this.error,
    required this.data,
    required this.msg,
  });

  bool error;
  Version data;
  String msg;

  factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
    error: json["error"],
    data: Version.fromJson(json["data"]),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": data.toJson(),
    "msg": msg,
  };
}

class Version {
  Version({
    required this.version,
    required this.versionCode,
    required this.forceUpdate,
  });

  String version;
  int versionCode;
  int forceUpdate;

  factory Version.fromJson(Map<String, dynamic> json) => Version(
    version: json["version"],
    versionCode: json["version_code"],
    forceUpdate: json["force_update"],
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "version_code": versionCode,
    "force_update": forceUpdate,
  };
}
