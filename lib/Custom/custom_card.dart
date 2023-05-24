import 'package:flutter/material.dart';
import 'package:frontend/Models/chat.model.dart';
import 'package:frontend/Screens/individual_chats.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.chat}) : super(key: key);

  final LastMessages chat;

  String formatMessageDate(String dateString) {
    DateTime now = DateTime.now();
    DateTime messageDate = DateTime.parse(dateString);
    Duration difference = now.difference(messageDate);

    if (difference.inSeconds < 1) {
      return "Just now";
    } else if (difference.inSeconds < 60) {
      return "${difference.inSeconds} seconds ago";
    } else if (difference.inHours < 24 && now.day == messageDate.day) {
      return '${messageDate.hour.toString().padLeft(2, '0')}:${messageDate.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1 ||
        (difference.inHours < 24 && now.day != messageDate.day)) {
      return "Yesterday";
    } else {
      return DateFormat('dd MMM yyyy').format(messageDate);
    }
  }

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
              child: chat.receiver!.isAvatar == false
                  ? const Icon(
                      Icons.person,
                      color: Colors.white,
                    )
                  : ClipOval(
                    child: Image.network(
                        chat.receiver!.avatar.toString(),
                        fit: BoxFit.cover,
                        width: 200,
                      ),
                  ),
            ),
            trailing: Text(
              formatMessageDate(
                chat.lastMessage!.createdAt.toString(),
              ),
            ),
            title: Text(
              chat.receiver!.name.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Row(
              children: [
                if (chat.lastMessage?.read == true)
                  const Icon(
                    Icons.done_all,
                    color: Color.fromARGB(255, 11, 36, 71),
                  )
                else
                  const Icon(Icons.done),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  chat.lastMessage!.message.toString(),
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
