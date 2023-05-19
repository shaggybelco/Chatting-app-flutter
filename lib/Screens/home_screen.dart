import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Pages/chat_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> screens = const [
    ChatPage(),
    Center(
      child: Text('Status'),
    ),
    Center(
      child: Text('contacts'),
    )
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
        automaticallyImplyLeading: false,
        title: const Text("Belco"),
        actions: [
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (kDebugMode) {
                print(value);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "New group",
                  child: Text("New group"),
                ),
                const PopupMenuItem(
                  value: "Settings",
                  child: Text("Settings"),
                ),
                const PopupMenuItem(
                  value: "Logout",
                  child: Text("Logout"),
                ),
              ];
            },
          ),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(255, 12, 19, 79),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 11, 36, 71),
                Color.fromARGB(255, 165, 215, 232),
              ],
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            selectedIconTheme:
                const IconThemeData(color: Colors.white, size: 40),
            unselectedItemColor: Colors.white70,
            onTap: (newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_rounded,
                  ),
                  label: "Chats",
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.timelapse_rounded,
                  ),
                  label: "Status",
                  backgroundColor: Colors.red),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.phone_rounded,
                  ),
                  label: "Contacts",
                  backgroundColor: Colors.yellow),
            ],
          ),
        ),
      ),
    );
  }
}
