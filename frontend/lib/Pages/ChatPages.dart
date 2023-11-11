import 'package:flutter/material.dart';
import 'package:frontend/CustomUI/CustomCard.dart';
import 'package:frontend/Model/ChatModel.dart';
import 'package:frontend/Screens/SelectContact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<chatModel> chats = [
    chatModel(
        name: "Shrey",
        isGroup: false,
        time: "14:00",
        currentMessage: "Hello",
        status: "Hello I'm using WhatsApp"),
    chatModel(
        name: "Developer",
        isGroup: false,
        time: "14:00",
        currentMessage: "Bolo",
        status: "Hello I'm using WhatsApp"),
    chatModel(
        name: "Front-End",
        isGroup: true,
        time: "14:00",
        currentMessage: "poco",
        status: "Hello I'm using WhatsApp"),
    chatModel(
        name: "Back-End",
        isGroup: true,
        time: "14:00",
        currentMessage: "Long Chat is shown",
        status: "Hello I'm using WhatsApp"),
    chatModel(
        name: "Demo",
        isGroup: false,
        time: "14:00",
        currentMessage: "Whatsapp Clone",
        status: "Hello I'm using WhatsApp"),
    chatModel(
        name: "Demo2",
        isGroup: true,
        time: "14:00",
        currentMessage: "Facebook",
        status: "Hello I'm using WhatsApp"),
    chatModel(
        name: "Demo3",
        isGroup: false,
        time: "14:00",
        currentMessage: "Facebook",
        status: "Hello I'm using WhatsApp"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(chatblock: chats[index]),
      ),
    );
  }
}
