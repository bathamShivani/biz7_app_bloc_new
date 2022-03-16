
import 'dart:math';

import 'package:biz_app_bloc/core/exceptions/custom_exception.dart';
import 'package:biz_app_bloc/data/api/api_client.dart';
import 'package:biz_app_bloc/data/data_helper.dart';
import 'package:biz_app_bloc/model/Category.dart';
import 'package:biz_app_bloc/model/Login.dart';
import 'package:biz_app_bloc/model/News.dart';
import 'package:biz_app_bloc/model/User.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



//const buildApiEnvironment = ApiEnvironment.development;

class ApiEndPoints {

  static const String BASE_URL = "https://biz7.app/";
  static const String API_KEY = "";
  static const String BASE_IMAGE_URL = "https://biz7.app/assets/news_images/";
  // Login API Url
  static final String loginUrl = 'api-login-otp';
  static final String otpUrl = 'api-authenticate';
  static final String categoryUrl = 'api-category';
  static final String newsUrl = 'api-news';
  static final String bookmarkUrl = 'api-get-bookmark-news';
  static final String updatebookmarkUrl = 'api-bookmark-news';
  static final String updateProfile = 'api-update-profile';
  static final String updateProfilePic = 'api-update-profile-pic';

}

abstract class ApiHelper {
  Future<Either<CustomException, Login>> executeLogin(String mobile,String fcmToken);
  Future<Either<CustomException, User>> executeVerifyOtp(String mobile, String ot);
  Future<Either<CustomException, Category>> executeCategory();
  Future<Either<CustomException, NewsCategory>> executeNews(int page, List<int> categories,int user_id,String search_text);
  Future<Either<CustomException, NewsCategory>> executeBookmark(int page, List<int> categories,int user_id);
  Future<Either<CustomException, String>> updateBookmark(int news_id, int is_bookmark,int user_id);
  Future<Either<CustomException, User>> updateProfile(int user_id, String fname,String lname,String dob,String gender,String email,String address);
  Future<Either<CustomException, User>> updateProfilePic(int user_id, path);

}

class ApiHelperImpl extends ApiHelper {
  ApiHelperImpl(this._api);
  final ApiClient _api;

  @override
  Future<Either<CustomException, Login>> executeLogin(String mobile,String fcmToken) async {
    print('mobile>>'+mobile);
    try {
      final response =
      await _api.post( ApiEndPoints.loginUrl, {
        'phone': mobile,
        'device_id':fcmToken,
        'let': "11.222",
        'lng': "11.333"
      });


      if(!response['error']){
        return Right(Login.fromJson(response));
      }else{
        return Left(throw new CustomException(200,response['msg'],"'"));
      }

    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, User>> executeVerifyOtp(String id,String otp) async {
    print('otp>>'+otp);
    try {
      final response =
      await _api.post( ApiEndPoints.otpUrl, {
        "id":id,
        "otp":otp

      });

      if(!response['error']){
        return Right(User.fromJson(response));
      }else{
        return Left(throw new CustomException(200,response['msg'],"'"));
      }

    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, Category>> executeCategory() async {
    try {
      final response =
      await _api.get(ApiEndPoints.categoryUrl);
      return Right(Category.fromJson(response));
    } on CustomException catch (e) {
      return Left(e);
    }
  }
  @override
  Future<Either<CustomException, NewsCategory>> executeNews(page, List<int> categories,user_id,String search_text) async {
    //final result = userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    try {
      final response =
      await _api.post( ApiEndPoints.newsUrl, {
        "page": page, "category_ids": categories, "user_id": user_id,"search_txt":search_text
      });

      if(!response['error']){
        return Right(NewsCategory.fromJson(response));
      }else{
        return Left(throw new CustomException(200,response['msg'],"'"));
      }

    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, NewsCategory>> executeBookmark(page, List<int> categories,user_id) async {
    //final result = userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    try {
      final response =
      await _api.post( ApiEndPoints.bookmarkUrl, {
        "page": page, "category_ids": categories, "user_id": user_id
      });
      if(response["error"]==false) {
      return Right(NewsCategory.fromJson(response));
      }
      return Left(throw CustomException(300,response["msg"],'rr'));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, String>> updateBookmark(news_id, isbookmark,user_id) async {

    //final result = userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    try {
      final response =
      await _api.post( ApiEndPoints.updatebookmarkUrl, {
        "news_id":news_id,
        "is_bookmark":isbookmark, "user_id": user_id
      });
      if(response["error"]==false){
      return Right(response["msg"]);}
      return Left(throw CustomException(300,response["msg"],'rr'));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, User>> updateProfile(user_id,fname,lname,dob,gender,email,address) async {

    //final result = userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    try {
      final response =
      await _api.post( ApiEndPoints.updateProfile, {

        "user_id":user_id,
        "first_name":fname,
        "last_name":lname,
        "dob":dob,
        "gender":gender,
        "email":email,
        "address":address
      });
      if(response["error"]==false){
      return Right(User.fromJson(response));}
      return Left(throw CustomException(300,response["msg"],'rr'));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, User>> updateProfilePic(user_id,path) async {

    //final result = userFromJson(await _dataHelper.cacheHelper.getUserInfo());
    try {
      final response =
      await _api.postMultiPart(path,user_id);
      if(response["error"]==false){
        return Right(User.fromJson(response));}
      return Left(throw CustomException(300,response["msg"],'rr'));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

}
