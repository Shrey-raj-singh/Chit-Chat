import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/Model/ChatModel.dart';
import 'package:frontend/Screens/Chatscreen.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.chatblock,
  }) : super(key: key);
  final chatModel chatblock;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(chatblock: chatblock,)));
      },
      child: Column(
        children: [
          ListTile(
            leading: InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: 30,
                child: SvgPicture.asset(
                  chatblock.isGroup ? "assets/groups.svg" : "assets/person.svg",
                  color: Colors.white,
                  height: 35,
                  width: 35,
                ),
                backgroundColor: Colors.blueGrey,
              ),
            ),
            title: Text(
              chatblock.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatblock.currentMessage,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(chatblock.time),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
