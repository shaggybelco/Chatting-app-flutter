import 'package:flutter/material.dart';

class ReceiverBubble extends StatelessWidget {
  const ReceiverBubble({super.key});

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
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 60,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(
                  "hey you dafasdfasd",
                  style: TextStyle(
                    color: Color.fromARGB(255, 11, 36, 71),
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  "20:52",
                  style: TextStyle(
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
