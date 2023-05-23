import 'package:hive_flutter/adapters.dart';

part 'token.adapter.g.dart';

@HiveType(typeId: 2)
class TokenModel{
  @HiveField(0)
  String? token;
  @HiveField(1)
  bool? isLoggedIn = false;
  TokenModel({this.token, this.isLoggedIn});
}