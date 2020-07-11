import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);

  final void Function(String emailAddress,String password, String username, bool isLogin) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Map<String,dynamic> _authData = {};
  final _formKey = GlobalKey<FormState>();
  String _emailAddress='', _userName='',_password='';
  bool _isLogin = true;

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

  void _submit(){
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    FocusScope.of(context).unfocus();
    widget.submitFn(_emailAddress,_password,_userName,_isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize:MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  key:ValueKey("email"),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                  ),
                  onSaved: (value){
                    _emailAddress = value;
                  },
                  validator: (value){
                    if(value.isEmpty || !value.contains('@')){
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                if (!_isLogin)
                TextFormField(
                  key:ValueKey("username"),
                  validator: (value){
                    if(value.isEmpty || value.length<4){
                      return "Enter username atleast 4 characters";
                    }
                    return null;
                  },
                  onSaved: (value){
                    _userName = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                ),
                TextFormField(
                  key:ValueKey("password"),
                  validator: (value){
                    if(value.isEmpty || value.length<7){
                      return "Enter password atleast 7 characters";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                  onSaved: (value){
                    _password = value;
                  },
                ),
                SizedBox(height: 12,),
                RaisedButton(
                  child: Text(_isLogin?"Login":"Signup"),
                  onPressed: (){
                    _submit();
                  },
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(_isLogin?"Create new account":"I already have an account"),
                  onPressed: (){
                    setState(() {
                      _isLogin=!_isLogin;
                    });
                  },
                )
              ]
            ),
          ),
        )),
      ),
    );
  }
}