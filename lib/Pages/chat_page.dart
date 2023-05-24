import 'package:flutter/material.dart';
import 'package:frontend/Custom/custom_card.dart';
import 'package:frontend/Models/chat.model.dart';
import 'package:frontend/Screens/select_contact.dart';

import '../Services/getUserChats.service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GetChats apiservice = GetChats();
  @override
  void initState() {
    super.initState();
    fetchChats();
  }

  final List<LastMessages> chatList = [];

  fetchChats() async{
    apiservice.getUserMessage().then(
          (value) => {
            if (value.error!.error.toString() != '')
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value.error!.error.toString(),
                    ),
                  ),
                ),
              }
            else
              {
                setState(() {
                  chatList.addAll(value.lastMessages ?? []);
                }),
              }
          },
        );
  }

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
        itemCount: chatList.length,
        itemBuilder: (context, index) => CustomCard(
          chat: chatList[index],
        ),
      ),
    );
  }
}
