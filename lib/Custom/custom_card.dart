import 'package:flutter/material.dart';
import 'package:frontend/Models/chat_model.dart';
import 'package:frontend/Screens/individual_chats.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.chat}) : super(key: key);

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualChats(chats: chat),
          ),
        ),
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: const Color.fromARGB(255, 11, 36, 71),
              child: Icon(
                chat.isGroup ? Icons.groups_2 : Icons.person,
                color: Colors.white,
              ),
            ),
            trailing: Text(chat.time),
            title: Text(
              chat.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  chat.currentMessage,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20.0, left: 80),
            child: Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
