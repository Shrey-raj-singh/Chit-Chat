import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          color: Color(0xffdcf8c6),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, right: 50, top: 5, left: 10),
                child: Text("Hey this is own side message card. And I want to use a bold action button",
                style: TextStyle(
                  fontSize: 16,
                ),),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text("20:18", style: TextStyle(fontSize: 13, color: Colors.grey),),
                    SizedBox(width: 5,),
                    Icon(Icons.done_all, size: 20,)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
