import 'package:flutter/material.dart';

import './login.dart';
import './auth.dart';
import './home.dart';
class RootPage extends StatefulWidget {

  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus{
  signedIn,
  signedOut
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.signedOut;

  _signedIn(){
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  _signedOut(){
    setState(() {
      _authStatus = AuthStatus.signedOut;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId){
      setState((){
        _authStatus = userId == null ? AuthStatus.signedOut : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(_authStatus){
      case AuthStatus.signedOut:
        return new LoginPage(auth: widget.auth, onSignedIn:_signedIn);
      case AuthStatus.signedIn:
        return new HomePage(auth: widget.auth, onSignedOut:_signedOut);
      default:
        return new Scaffold(
          body : new Container(
            child:new Text("New Page"),
          ),
        );
    }
  }
}