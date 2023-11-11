import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:frontend/Model/ChatModel.dart';

class ConatactCard extends StatelessWidget {
  const ConatactCard({
    Key? key,
    required this.contactsList,
  }) : super(key: key);
  final chatModel contactsList;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
                radius: 30,
                child: SvgPicture.asset(
                  contactsList.isGroup ? "assets/groups.svg" : "assets/person.svg",
                  color: Colors.white,
                  height: 30,
                  width: 30,
                ),
                backgroundColor: Colors.blueGrey,
              ),
              contactsList.select? Positioned(
                bottom: 4,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 11,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ): Container(),
          ],
        ),
      ),
      title: Text(
        contactsList.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contactsList.status,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
