import 'package:flutter/material.dart';

class Senderbubble extends StatelessWidget {
  const Senderbubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: const Color.fromARGB(255, 11, 36, 71),
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 60,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(
                  "hey you dafasdfasd fsadf asdf asdf sadf sadf sadf sadf sadf",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: const [
                    Text(
                      "20:52",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.done_all,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
