import 'dart:convert';
import 'package:biz_app_bloc/data/api/api_helper.dart';
import 'package:biz_app_bloc/utility/internet_check.dart';
import 'package:http/http.dart' as http;

class ApiClient {
   //InternetCheck _connectivity=InternetCheck();

  dynamic get(String path) async {
    print(
      path,
    );
    final response = await http.get(
      Uri.parse(ApiEndPoints.BASE_URL+path),
      headers: {
        'Content-Type': 'application/json',
        //'Authorization': token != null ? 'Bearer ${token}' : null
      },
    );
    print('response >>>>>>>>>>' + response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }


  dynamic post(String path, Map<String, dynamic> body) async {
   // if (await _connectivity.check()) {
      print('${ApiEndPoints.BASE_URL}$path');
      print('body' + json.encode(body));
      final response = await http.post(Uri.parse(ApiEndPoints.BASE_URL+path),
          headers: {
            'Content-Type': 'application/json',
            //'Authorization': token != null ? 'Bearer ${token}' : null
          },
          body: json.encode(body));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print(response.body);
        return json.decode(response.body);
      }
    /*}
    else {
      throw NetworkException(message: 'Opps, Internet is not available.');
    }*/
  }

  /*dynamic put(String path, String token, Map<String, String> body,
      [Map<String, String> params]) async {
    print('body' + body.toString() + getPutPath(path, params));
    final response = await _client.put(getPutPath(path, params),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: json.encode(body));
    print('response >>>>>>>>>>' + response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  String getPath(String path, Map<String, dynamic> params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params.forEach((key, value) {
        paramsString += '$key=$value';
      });
    }
    // first param handled only
    var url = '${ApiConstants.BASE_URL}$path' + '?' + '$paramsString';
    print('url >>>>>>' + url);
    return url;
  }

  String getPutPath(String path, Map<dynamic, dynamic> params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params.forEach((key, value) {
        paramsString += '/$value';
      });
    }
    return '${ApiConstants.BASE_URL}$path$paramsString';
  }

  dynamic postMultiPart(String filePath, int userId) async {
    try {
      print('filePath postMultiPart ->' + filePath);
      print('userId postMultiPart ->' + userId.toString());
      var request = new http.MultipartRequest(
          'POST', Uri.parse('${ApiConstants.BASE_URL}api-update-profile-pic'));
      request.fields.addAll({'user_id': userId.toString()});
      request.files.add(await http.MultipartFile.fromPath('img', filePath,
          contentType: MediaType('image', 'jpg')));

      var response = await request.send();

      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        print(res.body);

        print('uploaded');
        // response.stream.transform(utf8.decoder).listen((value) {
        //   print(value);
        return json.decode(res.body);
        // });
      } else {
        print('upload error');
        print(response.reasonPhrase);
      }
    } catch (err) {
      print('ERROR in  postMultiPart upload image $err');
    }
  }

  dynamic postMultiPartData(String path, String url,
      [token, family_member_id]) async {
    // try {
    print('family_member_id' + family_member_id);
    //   print('token' + token);
    //   print('url' + url);
    //   var dioRequest = dio.Dio();
    //   dioRequest.options.baseUrl = '${ApiConstants.BASE_URL}';
    //   dioRequest.options.headers = {
    //     'Content-Type': 'multipart/form-data',
    //     'Authorization': token != null ? 'Bearer ${token}' : null
    //   };
    //   var formData = new dio.FormData.fromMap({});
    //   formData.fields.add(MapEntry('family_member', family_member_id));
    //   var file = await dio.MultipartFile.fromFile(url);

    //   formData.files.add(MapEntry('file', file));
    //   print(formData);
    //   var response = await dioRequest.post(
    //     path,
    //     data: formData,
    //   );
    //   print('response' + response.toString());
    //   if (response.statusCode == 200) {
    //     return json.decode(response.toString());
    //   } else {
    //     print(response.statusMessage);
    //     throw Exception(response.statusMessage);
    //   }
    // } catch (err) {
    //   print('ERROR  $err');
    // }
    var headers = {'Authorization': 'Bearer ${token}'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.BASE_URL}document/strapi-upload'));
    request.fields.addAll({'family_member': family_member_id});
    request.files.add(await http.MultipartFile.fromPath('document', url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      // String res = await response.stream.bytesToString();
      String res;
      await response.stream.bytesToString().then((value) {
        print(value);
        res = value;
      });
      return res;
      // }
    } else {
      print(response.reasonPhrase);
    }
  }*/
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'Network error occurred. '});
}
