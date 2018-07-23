import 'package:flutter/material.dart';

import './auth.dart';

class HomePage extends StatelessWidget {
  HomePage ({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut()async{
    try {
      auth.signOut();
      onSignedOut();
    }
    catch(err){
      print('Error in Signout - $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome to Home Page"),
        actions: <Widget>[
          new FloatingActionButton(
            onPressed: _signOut,
            tooltip: 'Logout',
            child: new Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'This is Home Page:',
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
