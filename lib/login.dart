import 'package:flutter/material.dart';

import './auth.dart';
class LoginPage extends StatefulWidget {

  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType{
    login,
    register
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState(){
//    print("Signing in google n firebase");
//    print(_testSignInWithGoogle());
  }

  String _email;
  String _password;
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;

  bool loginSuccess(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      print("Form is valid, Email : $_email, Password : $_password");
      return true;
    }
    return false;
  }

  void onSubmit() async{
    if(loginSuccess()){
        try {
          if(_formType == FormType.login) {
            print("trying to Login");
            String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
            print('$userId: Logged in successfully');
          }
          else{
            print("trying to Register");
            String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
            print('$userId: Registered user successfully');
          }
          print("Yeppee Regitered!");
          widget.onSignedIn();
        }
        catch(err){
          print("Login falied with error - $err");
        }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;      
    });
  }
  
  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter Login App'),
        ),
        body: new Container(
          padding: EdgeInsets.all(20.0),
          child: new Form(
              key: formKey,
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs() +  buildSubmitButtons(),
              ),
          ),
        )
    );
  }

  List<Widget> buildSubmitButtons(){
    if(_formType == FormType.login){
      return [
        new RaisedButton(
          child: new Text("Login", style: new TextStyle(fontSize: 20.0),),
          onPressed: onSubmit,
        ),
        new FlatButton(
          child: new Text("Create an account", style: new TextStyle(fontSize: 20.0),),
          onPressed: moveToRegister,
        ),
      ];// This trailing comma
    }
    else {
      return [
        new RaisedButton(
          child: new Text("Create an account", style: new TextStyle(fontSize: 20.0),),
          onPressed: onSubmit,
        ),
        new FlatButton(
          child: new Text("Have an account? Login", style: new TextStyle(fontSize: 20.0),),
          onPressed: moveToLogin,
        ),
      ];// This trailing comma
    }
  }

  List<Widget> buildInputs(){
    if(_formType == FormType.login){
      return [
        new TextFormField(
          decoration: new InputDecoration(labelText: "Email "),
          validator: (value)=> value.isEmpty? "Email value cannot be empty": null,
          onSaved: (value) => _email = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: "Password "),
          validator: (value)=> value.isEmpty? "Password value cannot be empty": null,
          onSaved: (value) => _password = value,
          obscureText: true,
        ),
      ];
    }
    else {
      return [
        new TextFormField(
          decoration: new InputDecoration(labelText: "Email "),
          validator: (value)=> value.isEmpty? "Email value cannot be empty": null,
          onSaved: (value) => _email = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: "Password "),
          validator: (value)=> value.isEmpty? "Password value cannot be empty": null,
          onSaved: (value) => _password = value,
          obscureText: true,
        ),
      ];
    }
  }
}