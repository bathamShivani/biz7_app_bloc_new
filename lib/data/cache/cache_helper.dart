import 'dart:convert';

import 'package:biz_app_bloc/core/cache_client.dart';



abstract class CacheKeys {
  static final String token = 'token';
  static final String fcmToken = 'fcmToken';
  //User Data
  static final String userInfo = 'userInfo';

  static final String downloadedVideos = 'downloaded_videos';
}

abstract class CacheHelper {
  Future<String> getAccessToken();

  Future saveAccessToken(String token);

  Future<String> getFcmToken();

  Future saveFcmToken(String token);

  Future<String> getUserInfo();

  Future saveUserInfo(String userInfo);


}

class CacheHelperImpl extends CacheHelper {
  CacheHelperImpl(this._cache);

  final CacheClient _cache;
  @override
  Future<String> getFcmToken() {
    return _cache.getString(CacheKeys.fcmToken);
  }

  @override
  Future saveFcmToken(String token) {
    return _cache.putString(CacheKeys.fcmToken, token);
  }

  @override
  Future<String> getAccessToken() {
    return _cache.getString(CacheKeys.token);
  }

  @override
  Future<String> getUserInfo() {
    return _cache.getString(CacheKeys.userInfo);
  }

  @override
  Future saveAccessToken(String token) {
    return _cache.putString(CacheKeys.token, token);
  }

  @override
  Future saveUserInfo(String userInfo) {
    return _cache.putString(CacheKeys.userInfo, userInfo);
  }


}
