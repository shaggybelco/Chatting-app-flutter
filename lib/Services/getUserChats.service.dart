import 'dart:convert';
import 'dart:io';
import 'package:frontend/Constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Models/login_model.dart';

class GetChats {
  Future<AuthResponseModel> login(LoginModel requestModel) async {
    try {
      final response = await http.post(
        Uri.parse('${baseurl}log'),
        body: requestModel.toJson(),
      );

      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          return AuthResponseModel.fromJson(data);
        case 400:
          final data = json.decode(response.body);
          return AuthResponseModel.fromJson(data);

        default:
          throw Exception(response.body);
      }
    } on SocketException catch (_) {
      rethrow;
    }
  }
}
