import 'package:flutter/material.dart';
import 'package:productivityapp/models/global.dart';
import 'package:productivityapp/models/Widgets/intray_productivity_widget.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<IntrayProductivity> todoItems = [];
  @override
  Widget build(BuildContext context) {
    todoItems = getList();
    return Container(
        color: darkGreyColor, child: _buildReorderableListSimple(context));
    // child: ReorderableListView(
    //   padding: EdgeInsets.only(
    //     top: 300,
    //   ),
    //   children: getList(),
    //   onReorder: _onReorder,
    // ));
  }

  Widget _buildListTile(BuildContext context, IntrayProductivity item) {
    return ListTile(
      key: Key(item.keyValue),
      title: item,
    );
  }

  Widget _buildReorderableListSimple(BuildContext context) {
    return ReorderableListView(
      // handleSide: ReorderableListSimpleSide.Right,
      // handleIcon: Icon(Icons.access_alarm),
      padding: EdgeInsets.only(top: 300.0),
      children: todoItems
          .map((IntrayProductivity item) => _buildListTile(context, item))
          .toList(),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          IntrayProductivity item = todoItems[oldIndex];
          todoItems.remove(item);
          todoItems.insert(newIndex, item);
        });
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final IntrayProductivity item = todoItems.removeAt(oldIndex);
      todoItems.insert(newIndex, item);
    }
  }

  List<Widget> getList() {
    for (int i = 0; i < 10; i++) {
      todoItems.add(IntrayProductivity(keyValue: i.toString(), title: "Hello"));
    }
    return todoItems;
  }
}
