import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chat/message-bubble.dart';
import 'package:intl/intl.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState != ConnectionState.waiting) {
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chat")
                    .orderBy("createdOn", descending: true)
                    .snapshots(),
                builder: (ctx, chatSnapShots) {
                  if (chatSnapShots.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final chatsDoc = chatSnapShots.data.documents;
                  return ListView.builder(
                    reverse: true,
                    itemCount: chatsDoc.length,
                    itemBuilder: (ctx, index) {
                      var time = chatsDoc[index]["createdOn"].seconds;
                      var format = DateFormat('dd-MM-yyyy HH:mm');
                      var date =
                          DateTime.fromMillisecondsSinceEpoch(time * 1000);
                      return MessageBubble(
                          chatsDoc[index]["text"],
                          format.format(date),
                          chatsDoc[index]["userId"] == snapShot.data.uid
                              ? true
                              : false,
                          chatsDoc[index]["username"],
                          key: ValueKey(chatsDoc[index].documentID));
                    },
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
