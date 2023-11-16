import 'package:flutter/material.dart';

class ReplyMessageCard extends StatelessWidget {
  const ReplyMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          // color: Color(0xffdcf8c6),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, right: 5, top: 5, left: 10),
                child: Text("Hey this is reply side message card. And I want to use a mode action button",
                style: TextStyle(
                  fontSize: 16,
                ),),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text("20:18", style: TextStyle(fontSize: 13, color: Colors.grey),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
