import 'package:flutter/material.dart';
import 'package:productivityapp/bloc/blocs/user_blocs_provider.dart';
import 'package:productivityapp/models/classes/user.dart';
import 'package:productivityapp/models/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback signupPressed;
  final bool newUser;

  const LoginPage({Key key, this.signupPressed, this.newUser})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreyColor,
      body: Center(
        child: widget.newUser ? getSignupPage() : getSigninPage(),
      ),
    );
  }

  Widget getSigninPage() {
    TextEditingController usernameText = new TextEditingController();
    TextEditingController passwordText = new TextEditingController();

    return Container(
        child: Column(
      children: <Widget>[
        Text('Welcome to the app!'),
        TextField(
          decoration: InputDecoration(hintText: 'Username'),
          controller: usernameText,
        ),
        TextField(
          decoration: InputDecoration(hintText: 'Password'),
          controller: passwordText,
        )
      ],
    ));
  }

  Widget getSignupPage() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TextField(
              controller: firstnameController,
              decoration: InputDecoration(hintText: 'Firstname')),
          TextField(
              controller: lastnameController,
              decoration: InputDecoration(hintText: 'Lastname')),
          TextField(
              controller: usernameController,
              decoration: InputDecoration(hintText: 'Username')),
          TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email')),
          TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password')),
          FlatButton(
            color: Colors.red,
            child: Text('Sign Up'),
            onPressed: () {
              User user;
              if (firstnameController.text != null ||
                  lastnameController.text != null ||
                  usernameController.text != null ||
                  emailController.text != null ||
                  passwordController.text != null)
                bloc
                    .registerUser(
                        firstnameController.text,
                        lastnameController.text,
                        usernameController.text,
                        emailController.text,
                        passwordController.text)
                    .then((_) {
                  widget.signupPressed();
                });
            },
          )
        ],
      ),
    );
  }
}
