import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Custom/receiver_bubble.dart';
import 'package:frontend/Custom/sender_bubble.dart';
import 'package:frontend/Models/chat.model.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:frontend/Pages/camera_page.dart';
import 'package:frontend/Services/auth.hive.dart';
import 'package:frontend/Services/getUserChats.service.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualChats extends StatefulWidget {
  const IndividualChats({Key? key, required this.chats}) : super(key: key);

  final LastMessages chats;
  @override
  State<IndividualChats> createState() => _IndividualChatsState();
}

class _IndividualChatsState extends State<IndividualChats> {
  bool emojiShowing = false;
  FocusNode focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final GetChats getChats = GetChats();
  late IO.Socket socket;

  late String userId = "";
  void getUser() async {
    await getChats.getUser().then(
          (value) => {
            setState(() {
              userId = value.id.toString();
            }),
            print(value.id),
          },
        );
  }

  void connect() {
    socket.onConnect(
      (data) => {
        print("connection done"),
        socket.emit(
          "connected",
          {
            "userID": userId,
          },
        )
      },
    );

    print(socket.connected);
    socket.onConnectError((data) => {print("Connetcion error: " + data)});

    socket.onDisconnect((data) => print("Disconnection done"));
  }

  @override
  void initState() {
    super.initState();
    socket = IO.io(
      "http://192.168.255.117:3333",
      IO.OptionBuilder().setTransports(["websocket"]).setQuery({
        "username": widget.chats.receiver!.id.toString(),
      }).build(),
    );

    connect();
    getUser();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/chat.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: const Color.fromARGB(242, 224, 224, 224),
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
            leadingWidth: 80,
            titleSpacing: 3,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(Icons.arrow_back),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color.fromARGB(255, 165, 215, 232),
                    child: widget.chats.receiver!.isAvatar == false
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                          )
                        : ClipOval(
                            child: Image.network(
                              widget.chats.receiver!.avatar.toString(),
                              fit: BoxFit.cover,
                              width: 200,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chats.receiver!.name.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      "last seen today at 12:05",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.videocam,
                  color: Colors.white,
                ),
              ),
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.call,
                  color: Colors.white,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {},
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: "View contact",
                      child: Text("View contact"),
                    ),
                    const PopupMenuItem(
                      value: "Media, Links, and Docs",
                      child: Text("Media, Links, and Docs"),
                    ),
                    const PopupMenuItem(
                      value: "Search",
                      child: Text("Search"),
                    ),
                    const PopupMenuItem(
                      value: "Mute Notification",
                      child: Text("Mute Notification"),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 180,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (widget.chats.receiver!.id.toString() != userId) {
                        return const Senderbubble();
                      } else {
                        return const ReceiverBubble();
                      }
                    },
                    itemCount: widget.chats.filteredMessages!.length,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 65,
                              child: Card(
                                margin: const EdgeInsets.only(
                                    left: 2, right: 2, bottom: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  controller: _controller,
                                  focusNode: focusNode,
                                  onTap: () {
                                    setState(
                                      () {
                                        emojiShowing = false;
                                      },
                                    );
                                  },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type a message",
                                    contentPadding: const EdgeInsets.all(15),
                                    prefixIcon: IconButton(
                                      onPressed: () {
                                        focusNode.unfocus();
                                        focusNode.canRequestFocus = false;
                                        setState(
                                          () {
                                            emojiShowing = !emojiShowing;
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.emoji_emotions_outlined,
                                        color:
                                            Color.fromARGB(255, 165, 215, 232),
                                      ),
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                            color: Color.fromARGB(
                                                255, 165, 215, 232),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) =>
                                                  attachModal(context),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, left: 5),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    const Color.fromARGB(255, 165, 215, 232),
                                foregroundColor:
                                    const Color.fromARGB(200, 11, 36, 71),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.mic),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Offstage(
                          offstage: !emojiShowing,
                          child: SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              textEditingController: _controller,
                              config: Config(
                                columns: 7,
                                // Issue: https://github.com/flutter/flutter/issues/28894
                                emojiSizeMax: 32 *
                                    (foundation.defaultTargetPlatform ==
                                            TargetPlatform.iOS
                                        ? 1.30
                                        : 1.0),
                                verticalSpacing: 0,
                                horizontalSpacing: 0,
                                gridPadding: EdgeInsets.zero,
                                initCategory: Category.RECENT,
                                bgColor: const Color(0xFFF2F2F2),
                                indicatorColor:
                                    const Color.fromARGB(200, 11, 36, 71),
                                iconColor: Colors.grey,
                                iconColorSelected:
                                    const Color.fromARGB(200, 11, 36, 71),
                                backspaceColor:
                                    const Color.fromARGB(200, 11, 36, 71),
                                skinToneDialogBgColor: Colors.white,
                                skinToneIndicatorColor: Colors.grey,
                                enableSkinTones: true,
                                showRecentsTab: true,
                                recentsLimit: 28,
                                replaceEmojiOnLimitExceed: false,
                                noRecents: const Text(
                                  'No Recents',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black26),
                                  textAlign: TextAlign.center,
                                ),
                                loadingIndicator: const SizedBox.shrink(),
                                tabIndicatorAnimDuration: kTabScrollDuration,
                                categoryIcons: const CategoryIcons(),
                                buttonMode: ButtonMode.MATERIAL,
                                checkPlatformCompatibility: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget cameraModal() {
  return const SizedBox();
}

Widget attachModal(BuildContext context) {
  return SizedBox(
    height: 300,
    child: Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconCreation(
                    Icons.insert_drive_file, Colors.indigo, "Document", () {}),
                iconCreation(Icons.camera_alt, Colors.pink, "Camera", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CameraPage(),
                    ),
                  );
                }),
                iconCreation(
                    Icons.insert_photo, Colors.purple, "Gallery", () {}),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconCreation(Icons.headset, Colors.orange, "Audio", () {}),
                iconCreation(
                    Icons.location_pin, Colors.teal, "Location", () {}),
                iconCreation(Icons.person, Colors.blue, "Contact", () {}),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget iconCreation(
    IconData icon, Color color, String name, VoidCallback clicked) {
  return InkWell(
    onTap: clicked,
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(
            color: Colors.white,
            icon,
            size: 29,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}
