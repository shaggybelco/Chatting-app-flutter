import 'package:flutter/material.dart';
import 'package:frontend/Custom/avatar_card.dart';
import 'package:frontend/Custom/contact_card.dart';
import 'package:frontend/Models/contact_model.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
  List<ContactModal> groups = [];

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "New group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "Add participants",
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
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: groups.isNotEmpty ? 75 : 0),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (users[index].select == false) {
                      setState(() {
                        users[index].select = true;
                        groups.add(users[index]);
                      });
                    } else {
                      setState(() {
                        users[index].select = false;
                        groups.remove(users[index]);
                      });
                    }
                  },
                  child: ContactCard(
                    contacts: users[index],
                  ),
                );
              },
            ),
          ),
          if (groups.isNotEmpty)
            Column(
              children: [
                Container(
                  height: 75,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: groups.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {},
                      child: AvatarCard(groups: groups[index]),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
