// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NewsCategory categoryFromJson(String str) => NewsCategory.fromJson(json.decode(str));

String categoryToJson(NewsCategory data) => json.encode(data.toJson());

class NewsCategory {
  NewsCategory({
    required this.error,
    required this.data,
    required this.msg,
  });

  bool error;
  List<News> data;
  String msg;

  factory NewsCategory.fromJson(Map<String, dynamic> json) => NewsCategory(
    error: json["error"],
    data: List<News>.from(json["data"].map((x) => News.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class News {

  int newsId;
  int catId;
  String catName;
  String newsTitle;
  String newsDescription;
  String smallImg;
  String bigImg;
  String newsSource;
  String newsCountry;
  String newsFooter;
  String newsDate;
  String createdDate;
  int isBookmark;

  News({

    required this.newsId,
    required this.catId,
    required this.catName,
    required this.newsTitle,
    required this.newsDescription,
    required this.smallImg,
    required this.bigImg,
    required this.newsSource,
    required this.newsCountry,
    required this.newsFooter,
    required this.newsDate,
    required this.createdDate,
    required this.isBookmark});

  factory News.fromJson(Map<String, dynamic> json) =>
      News(

          newsId: json["news_id"],
          catId: json["cat_id"],
          catName: json["cat_name"],
          newsTitle: json["news_title"],
          newsDescription: json["news_description"],
          smallImg: json["small_img"],
          bigImg: json["big_img"],
          newsSource: json["news_source"],
          newsCountry: json["news_country"] == null
              ? null
              : json["news_country"],
          newsFooter: json["news_footer"] == null ? null : json["news_footer"],
          newsDate: json["news_date"],
          createdDate: json["created_date"],
          isBookmark: json["is_bookmark"]
      );


  Map<String, dynamic> toJson() =>
      {

        "news_id": newsId,
        "cat_id": catId,
        "cat_name": catName,
        "news_title": newsTitle,
        "news_description": newsDescription,
        "small_img": smallImg,
        "big_img": bigImg,
        "news_source": newsSource,
        "news_country": newsCountry,
        "news_footer": newsFooter,
        "news_date": newsDate,
        "created_date": createdDate,
        "is_bookmark": isBookmark,
      };
}
