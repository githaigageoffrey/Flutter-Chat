import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message,time;
  bool isMe;
  MessageBubble(this.message,this.time,this.isMe);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe?Colors.grey[300]:Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(message,
                  style: TextStyle(
                      color: isMe?Colors.black: Theme.of(context).accentTextTheme.title.color)),
            ),
            Container(
              
              width: 140,
              margin: EdgeInsets.only(top: 0, left: 8,bottom: 5,right:15),
              child: Text(time,
                  style: TextStyle(
                      color: Colors.black,fontSize: 10),textAlign: TextAlign.right),
            ),
          ],
        )
      ],
    );
  }
}
