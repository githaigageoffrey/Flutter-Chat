import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Chat App"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(child: Container(
                child: Row(
                  children: <Widget>[
                    Icon( Icons.exit_to_app),
                    SizedBox(width: 8,),
                    Text("Logout"),
                  ]
                ),
              ),
              value: 'logout',
              ),
            ],
            onChanged: (itemidentifier){
              if(itemidentifier=='logout'){
                FirebaseAuth.instance.signOut();
              }
            }
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("chats/GcKNhSdcuTxtWowMHBDR/messages")
            .snapshots(),
        builder: (ctx, streamSnapShot) {
          if(streamSnapShot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          final documents = streamSnapShot.data.documents;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(10), child: Text(documents[index]["text"])),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Firestore.instance
            .collection("chats/GcKNhSdcuTxtWowMHBDR/messages").add({
              "text" : "This is a user added button chat"
            });
          }),
    );
  }
}
