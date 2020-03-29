import 'package:flutter/material.dart';
import 'package:productivityapp/models/global.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: darkGreyColor,
        child: ListView(
          padding: EdgeInsets.only(
            top: 300,
          ),
          children: getList(),
        ));
  }

  List<Widget> getList() {
    List<Container> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(Container(
        height: 100,
        color: Colors.red,
      ));
      list.add(Container(
        height: 100,
        color: Colors.blue,
      ));
    }
    return list;
  }
}
