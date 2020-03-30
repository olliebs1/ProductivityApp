import 'package:flutter/material.dart';
import 'package:productivityapp/models/global.dart';

class IntrayProductivity extends StatelessWidget {
  final String title;
  final String keyValue;
  IntrayProductivity({this.keyValue, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(keyValue),
      margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          Radio(),
          Column(
            children: <Widget>[Text(title, style: darkToDoTitle)],
          )
        ],
      ),
    );
  }
}
