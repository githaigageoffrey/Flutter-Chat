import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chat/message-bubble.dart';

class Messages extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("chat").orderBy("createdOn", descending:true).snapshots(),
      builder: (ctx,chatSnapShots){
        if(chatSnapShots.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        final chatsDoc = chatSnapShots.data.documents;
        return ListView.builder(
          reverse: true,
          itemCount: chatsDoc.length,
          itemBuilder: (ctx,index){
            return  MessageBubble(chatsDoc[index]["text"]);
          },
        
        );
      },
    );
  }
}