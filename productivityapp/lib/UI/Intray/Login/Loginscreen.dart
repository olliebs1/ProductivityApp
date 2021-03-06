import 'package:flutter/material.dart';
import 'package:productivityapp/bloc/blocs/user_blocs_provider.dart';
import 'package:productivityapp/models/classes/user.dart';
import 'package:productivityapp/models/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:productivityapp/models/global.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback login;

  final bool newUser;

  const LoginPage({Key key, this.login, this.newUser}) : super(key: key);

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
        margin: EdgeInsets.only(top: 100, bottom: 100, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Welcome!',
              style: bigLightBlueTitle,
              textAlign: TextAlign.center,
            ),
            Container(
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Theme(
                    data: Theme.of(context)
                        .copyWith(splashColor: Colors.transparent),
                    child: TextField(
                      controller: usernameText,
                      autofocus: false,
                      style: TextStyle(fontSize: 22.0, color: darkGreyColor),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Username',
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(splashColor: Colors.transparent),
                    child: TextField(
                      controller: passwordText,
                      autofocus: false,
                      style: TextStyle(fontSize: 22.0, color: darkGreyColor),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    // color: redColor,
                    child: Text(
                      'Sign in',
                      style: redTodoTitle,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (usernameText.text != null ||
                          passwordText.text != null) {
                        userBloc
                            .signinUser(
                                usernameText.text, passwordText.text, '')
                            .then((_) {
                          widget.login();
                        });
                      }
                    },
                  )
                ],
              ),
            ),
            Container(
                child: Column(children: <Widget>[
              Text(
                "Don't have an account yet?",
                style: redText,
                textAlign: TextAlign.center,
              ),
              FlatButton(
                child: Text(
                  'Create one.',
                  style: redBoldText,
                  textAlign: TextAlign.center,
                ),
                onPressed: () {},
              )
            ]))
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
                userBloc
                    .registerUser(
                        firstnameController.text,
                        lastnameController.text,
                        usernameController.text,
                        emailController.text,
                        passwordController.text)
                    .then((_) {
                  widget.login();
                });
            },
          )
        ],
      ),
    );
  }
}
