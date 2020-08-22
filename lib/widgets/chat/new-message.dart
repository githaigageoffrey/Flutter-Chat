import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  var _enteredMessage = "";
  final _messageController = new TextEditingController();

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

  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    final auth = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection("chat").add({
      "text": _enteredMessage,
      "createdOn" : Timestamp.now(),
      "userId" : auth.uid,
    });
    setState(() {
      _enteredMessage = '';
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: "Send a message ...."),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            )
          ),
          IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage)
        ],
      ),
    );
  }
}
