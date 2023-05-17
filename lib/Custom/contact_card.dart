import 'package:flutter/material.dart';
import 'package:frontend/Models/contact_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contacts}) : super(key: key);
  final ContactModal contacts;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            const CircleAvatar(
              radius: 23,
              backgroundColor: Color.fromARGB(255, 165, 215, 232),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
            contacts.select
                ? const Positioned(
                    bottom: 0,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 11, 36, 71),
                      radius: 11,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      title: Text(
        contacts.name,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contacts.status,
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
