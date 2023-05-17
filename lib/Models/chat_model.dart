import 'package:flutter/material.dart';

class ChatModel {
  String name;
  IconData icon;
  bool isGroup;
  String time;
  String currentMessage;

  ChatModel(
      {required this.name,
      required this.icon,
      required this.isGroup,
      required this.time,
      required this.currentMessage});
}
