import 'package:flutter/material.dart';
import 'package:frontend/Custom/custom_card.dart';
import 'package:frontend/Models/chat_model.dart';
import 'package:frontend/Screens/select_contact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
      name: "shaggy",
      icon: Icons.person,
      isGroup: false,
      time: "12:02",
      currentMessage: "Hey there shaggy",
    ),
    ChatModel(
      name: "meeting everyone",
      icon: Icons.group,
      isGroup: true,
      time: "12:02",
      currentMessage: "Hey there everyone",
    ),
    ChatModel(
      name: "Man do",
      icon: Icons.person,
      isGroup: false,
      time: "12:02",
      currentMessage: "Hey there man do",
    ),
    ChatModel(
      name: "shaggy",
      icon: Icons.person,
      isGroup: false,
      time: "12:02",
      currentMessage: "Hey there shaggy",
    ),
    ChatModel(
      name: "meeting everyone",
      icon: Icons.group,
      isGroup: true,
      time: "12:02",
      currentMessage: "Hey there everyone",
    ),
    ChatModel(
      name: "Man do",
      icon: Icons.person,
      isGroup: false,
      time: "12:02",
      currentMessage: "Hey there man do",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => const Contacts(),
            ),
          );
        },
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
