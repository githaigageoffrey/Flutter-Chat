import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/auth-form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final _auth = FirebaseAuth.instance;

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

  void _submitForm(String emailAddress,String password, String username, bool isLogin,BuildContext ctx)async{
    AuthResult authResult;
    try{
      if(isLogin){
        authResult = await _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
      }else{
        authResult = await _auth.createUserWithEmailAndPassword(email: emailAddress, password: password);
      }
      print(authResult);
    }on PlatformException catch(err){
      var message = "Error occurred, please check your credentials";
      if(err.message !=null){
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        )
      );
    }catch(err){
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitForm));
  }
}
