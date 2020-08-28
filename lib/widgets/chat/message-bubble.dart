import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message,time,username;
  final bool isMe;
  final Key key;
  MessageBubble(this.message,this.time,this.isMe,this.username,{this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe?Colors.grey[300]:Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe?Radius.circular(0):Radius.circular(12),
                  bottomRight: isMe?Radius.circular(0):Radius.circular(12),
                ),
              ),
              width: MediaQuery.of(context).size.width*0.4,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                    future: Firestore.instance.collection("users").document(username).get(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Text("Loading .....");
                      }
                      return Text(snapshot.data.username,style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ));
                    }
                  ),
                  Text(message,
                    style: TextStyle(
                        color: isMe?Colors.black: Theme.of(context).accentTextTheme.title.color)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.4,
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
