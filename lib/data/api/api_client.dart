import 'dart:convert';
import 'package:biz_app_bloc/data/api/api_helper.dart';
import 'package:biz_app_bloc/utility/internet_check.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


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

  }

  dynamic postMultiPart(String filePath, int userId) async {
    try {
      print('filePath postMultiPart ->' + filePath);
      print('userId postMultiPart ->' + userId.toString());
      var request = new http.MultipartRequest(
          'POST', Uri.parse('${ApiEndPoints.BASE_URL}api-update-profile-pic'));
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


}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'Network error occurred. '});
}
