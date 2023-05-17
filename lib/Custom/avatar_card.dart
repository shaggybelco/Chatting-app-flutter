import 'package:flutter/material.dart';
import 'package:frontend/Models/contact_model.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, required this.groups, }): super(key: key);

  final ContactModal groups;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color.fromARGB(255, 165, 215, 232),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red[600],
                  radius: 8,
                  child: const Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
            ],
          ),
          Text(
            groups.name,
            style: const TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
