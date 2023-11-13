import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/Model/ChatModel.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:frontend/Screens/CameraScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.chatblock,
  }) : super(key: key);
  final chatModel chatblock;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;

  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Color(0xFF075E54),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CircleAvatar(
                radius: 22,
                child: SvgPicture.asset(
                  widget.chatblock.isGroup
                      ? "assets/groups.svg"
                      : "assets/person.svg",
                  color: Colors.white,
                  height: 35,
                  width: 35,
                ),
                backgroundColor: Colors.blueGrey,
              ),
            ],
          ),
        ),
        title: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chatblock.name,
                style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
              ),
              Text(
                "Last seen Today at 12:00",
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          PopupMenuButton(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contexts) {
              return [
                PopupMenuItem(
                  child: Text("View Contact"),
                  value: "View Contact",
                ),
                PopupMenuItem(
                  child: Text("Media, links, and docs"),
                  value: "Media, links, and docs",
                ),
                PopupMenuItem(
                  child: Text("Search"),
                  value: "Search",
                ),
                PopupMenuItem(
                  child: Text("Mute Notifications"),
                  value: "Mute Notifications",
                ),
                PopupMenuItem(
                  child: Text("Disappearing mesaages"),
                  value: "Disappearing mesaages",
                ),
                PopupMenuItem(
                  child: Text("Wallpaper"),
                  value: "Wallpaper",
                ),
                PopupMenuItem(
                  child: Text("More"),
                  value: "More",
                ),
              ];
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Stack(
            children: [
              ListView(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 55,
                          child: Card(
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, bottom: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextFormField(
                                focusNode: focusNode,
                                controller: _controller,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message...",
                                  prefixIcon: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      onPressed: () {
                                        focusNode.unfocus();
                                        focusNode.canRequestFocus = false;
                                        setState(() {
                                          emojiShowing = !emojiShowing;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.emoji_emotions,
                                        color: Color(0xFF128C7E),
                                      ),
                                    ),
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (builder) =>
                                                    bottomSheet());
                                          },
                                          icon: Icon(
                                            Icons.attach_file,
                                            color: Color(0xFF128C7E),
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (builder)=>CameraScreen()));
                                          },
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: Color(0xFF128C7E),
                                          )),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.all(5),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CircleAvatar(
                            backgroundColor: Color(0xFF128C7E),
                            radius: 25,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.mic,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Offstage(
                      offstage: !emojiShowing,
                      child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            onEmojiSelected: (category, emoji) {
                              setState(() {
                                _controller.text =
                                    _controller.text + emoji.emoji;
                              });
                            },
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
                              indicatorColor: Colors.blue,
                              iconColor: Colors.grey,
                              iconColorSelected: Colors.blue,
                              backspaceColor: Colors.blue,
                              skinToneDialogBgColor: Colors.white,
                              skinToneIndicatorColor: Colors.grey,
                              enableSkinTones: true,
                              recentTabBehavior: RecentTabBehavior.RECENT,
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
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // onWillPop: () {

          // },
          onWillPop: () {
            if (emojiShowing) {
              setState(() {
                emojiShowing = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.indigoAccent, "Docments"),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  iconCreation(Icons.insert_photo_rounded, Colors.deepPurple, "Gallery"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconCreation(Icons.headset, Colors.deepOrange, "Audio"),
                  iconCreation(Icons.location_pin, Colors.green, "Location"),
                  iconCreation(Icons.person, Colors.blueAccent, "Contacts"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color bgcolor, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: bgcolor,
            radius: 30,
            child: Icon(
              color: Colors.white,
              icon,
              size: 29,
            ),
          ),
          Text(text)
        ],
      ),
    );
  }
}
