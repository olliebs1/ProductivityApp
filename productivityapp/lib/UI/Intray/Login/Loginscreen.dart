import 'package:flutter/material.dart';
import 'package:productivityapp/bloc/blocs/user_blocs_provider.dart';

class LoginPage extends StatefulWidget {
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
      body: Center(
        child: Container(
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
                  if (firstnameController.text != null ||
                      lastnameController.text != null ||
                      usernameController.text != null ||
                      emailController.text != null ||
                      passwordController.text != null) {
                    bloc.registerUser(
                        firstnameController.text,
                        lastnameController.text,
                        usernameController.text,
                        emailController.text,
                        passwordController.text);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
