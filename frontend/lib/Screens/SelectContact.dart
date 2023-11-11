import 'package:flutter/material.dart';
import 'package:frontend/CustomUI/ButtonCard.dart';
import 'package:frontend/CustomUI/contactCard.dart';
import 'package:frontend/Model/ChatModel.dart';
import 'package:frontend/Screens/CreateGroup.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<chatModel> contactsList = [
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
    chatModel(
        name: "Demo3",
        isGroup: false,
        time: "14:00",
        currentMessage: "Facebook",
        status: "Hello I'm using WhatsApp"),
    chatModel(
        name: "Demo3",
        isGroup: false,
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
      appBar: AppBar(
        backgroundColor: Color(0xFF075E54),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "999 Contacts",
              style: TextStyle(
                fontSize: 13,
              ),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contexts) {
              return [
                PopupMenuItem(
                  child: Text("Invite a friend"),
                  value: "Invite a friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
                ),
              ];
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: contactsList.length+2,
        itemBuilder: (context,index) {
          if(index==0){
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>(CreateGroup())));
              },
              child: ButtonCard(name: "New groups", icon: Icons.group));
          }else if(index==1){
            return InkWell(
              onTap: () {},
              child: ButtonCard(name: "New Contact", icon: Icons.person_add));
          }
          return ConatactCard(contactsList:contactsList[index-2]);
        }),
    );
  }
}
