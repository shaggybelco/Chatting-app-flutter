import 'dart:convert';
import 'dart:io';
import 'package:frontend/Constants/constants.dart';
import 'package:frontend/Models/chat.model.dart';
import 'package:frontend/Services/auth.hive.dart';
import 'package:http/http.dart' as http;

class GetChats {
  Future<LastMessageResponse> getUserMessage() async {
    try {
      final response = await http.get(
        Uri.parse('${baseurl}userm'),
        headers: {
          HttpHeaders.authorizationHeader: await AuthHiveClient().getToken(),
        },
      );

      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          return LastMessageResponse.fromJson(data);
        case 400:
          final data = json.decode(response.body);
          return LastMessageResponse.fromJson(data);
        case 403:
          final data = json.decode(response.body);
          return LastMessageResponse.fromJson(data);
        case 401:
          final data = json.decode(response.body);
          return LastMessageResponse.fromJson(data);

        default:
          throw Exception(response.body);
      }
    } on SocketException catch (_) {
      rethrow;
    }
  }


  Future<User> getUser() async {
    try {
      final response = await http.get(
        Uri.parse('${baseurl}me'),
        headers: {
          HttpHeaders.authorizationHeader:
            await AuthHiveClient().getToken(),
        },
      );

      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          return User.fromJson(data);
        case 400:
          final data = json.decode(response.body);
          return User.fromJson(data);
        case 403:
          final data = json.decode(response.body);
          return User.fromJson(data);

        default:
          throw Exception(response.body);
      }
    } on SocketException catch (_) {
      rethrow;
    }
  }
}
