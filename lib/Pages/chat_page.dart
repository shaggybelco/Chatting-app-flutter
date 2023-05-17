import 'package:flutter/material.dart';
import 'package:frontend/Custom/custom_card.dart';
import 'package:frontend/Models/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
      "shaggy",
      Icons.person,
      false,
      "12:02",
      "Hey there shaggy",
    ),
    ChatModel(
      "meeting everyone",
      Icons.group,
      true,
      "12:02",
      "Hey there everyone",
    ),
    ChatModel(
      "Man do",
      Icons.person,
      false,
      "12:02",
      "Hey there man do",
    ),
    ChatModel(
      "shaggy",
      Icons.person,
      false,
      "12:02",
      "Hey there shaggy",
    ),
    ChatModel(
      "meeting everyone",
      Icons.group,
      true,
      "12:02",
      "Hey there everyone",
    ),
    ChatModel(
      "Man do",
      Icons.person,
      false,
      "12:02",
      "Hey there man do",
    ),
    ChatModel(
      "shaggy",
      Icons.person,
      false,
      "12:02",
      "Hey there shaggy",
    ),
    ChatModel(
      "meeting everyone",
      Icons.group,
      true,
      "12:02",
      "Hey there everyone",
    ),
    ChatModel(
      "Man do",
      Icons.person,
      false,
      "12:02",
      "Hey there man do",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 165, 215, 232),
        foregroundColor: const Color.fromARGB(255, 25, 55, 109),
        child: const Icon(Icons.chat_bubble),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(
          chat: chats[index],
        ),
      ),
    );
  }
}
