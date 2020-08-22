import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("chat").snapshots(),
      builder: (ctx,chatSnapShots){
        if(chatSnapShots.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        final chatsDoc = chatSnapShots.data.documents;
        return ListView.builder(
          itemCount: chatsDoc.length,
          itemBuilder: (ctx,index){
            return Text(chatsDoc[index]["text"]);
          },
        
        );
      },
    );
  }
}