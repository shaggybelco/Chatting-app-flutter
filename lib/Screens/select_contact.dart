import 'package:flutter/material.dart';
import 'package:frontend/Custom/button_card.dart';
import 'package:frontend/Custom/contact_card.dart';
import 'package:frontend/Models/contact_model.dart';
import 'package:frontend/Screens/create_group.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<ContactModal> users = [
    ContactModal(name: "shaggy", status: "Hey there"),
    ContactModal(name: "nom", status: "Hey there"),
    ContactModal(name: "hawa", status: "Hey there"),
    ContactModal(name: "nons", status: "Hey there"),
    ContactModal(name: "atau", status: "Hey there"),
    ContactModal(name: "magree", status: "Hey there"),
    ContactModal(name: "more", status: "Hey there"),
    ContactModal(name: "chacho", status: "Hey there"),
    ContactModal(name: "mogo", status: "Hey there"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 11, 36, 71),
                Color.fromARGB(255, 165, 215, 232),
              ],
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select contacts",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "265 contacts",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 26,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "Invite a friend",
                  child: Text("Invite a friend"),
                ),
                const PopupMenuItem(
                  value: "Contacts",
                  child: Text("Contacts"),
                ),
                const PopupMenuItem(
                  value: "Refresh",
                  child: Text("Refresh"),
                ),
                const PopupMenuItem(
                  value: "Help",
                  child: Text("Help"),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => const CreateGroup(),
                    ),
                  );
                },
                child: const ButtonCard(
                  icon: Icons.groups_2,
                  name: "New group",
                ));
          } else if (index == 1) {
            return const ButtonCard(
              icon: Icons.person_add,
              name: "New contact",
            );
          }
          return ContactCard(
            contacts: users[index - 2],
          );
        },
        itemCount: users.length + 2,
      ),
    );
  }
}
