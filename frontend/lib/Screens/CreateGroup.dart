import 'package:flutter/material.dart';
import 'package:frontend/CustomUI/AvtarCard.dart';
import 'package:frontend/CustomUI/contactCard.dart';
import 'package:frontend/Model/ChatModel.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
  List<chatModel> groups = [];
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
              "New group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "Add participants",
              style: TextStyle(
                fontSize: 13,
              ),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contactsList.length,
              itemBuilder: (context, index) {
                if (index==0) {
                  return Container(
                    height: groups.length>0?90:10,
                  );
                }
                return InkWell(
                    onTap: () {
                      if (contactsList[index-1].select == false) {
                        setState(() {
                          contactsList[index-1].select = true;
                          groups.add(contactsList[index-1]);
                        });
                      } else {
                        setState(() {
                          contactsList[index-1].select = false;
                          groups.remove(contactsList[index-1]);
                        });
                      }
                    },
                    child: ConatactCard(contactsList: contactsList[index-1]));
              }),
          groups.length>0? Column(
            children: [
              Container(
                height: 75,
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: contactsList.length,
                  itemBuilder: (context, index) {
                    if (contactsList[index].select) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              contactsList[index].select = false;
                              groups.remove(contactsList[index]);
                            });
                          },
                          child: AvtarCard(contacts: contactsList[index]));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Divider(
                thickness: 1,
              )
            ],
          ):Container(),
        ],
      ),
    );
  }
}
