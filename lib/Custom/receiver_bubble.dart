import 'package:flutter/material.dart';
import 'package:frontend/Models/chat.model.dart';
import 'package:intl/intl.dart';

class ReceiverBubble extends StatelessWidget {
  const ReceiverBubble({Key? key, required this.messages}) : super(key: key);
  final LastMessage messages;

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
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.white,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 60,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(
                  messages.message.toString(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 11, 36, 71),
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  formatMessageDate(messages.createdAt.toString()),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
