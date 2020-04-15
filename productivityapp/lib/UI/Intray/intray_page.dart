import 'package:flutter/material.dart';
import 'package:productivityapp/bloc/blocs/user_blocs_provider.dart';
import 'package:productivityapp/models/classes/task.dart';
import 'package:productivityapp/models/global.dart';
import 'package:productivityapp/models/Widgets/intray_productivity_widget.dart';

class IntrayPage extends StatefulWidget {
  final String apiKey;
  IntrayPage({this.apiKey});

  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        color: darkGreyColor,
        child: FutureBuilder(
          future: getList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              taskList = snapshot.data;
            } else {
              print('no data');
            }
            // apiKey.length > 0 ? getHomePage() :
            return _buildReorderableListSimple(context, taskList);
          },
        ));
    // child: ReorderableListView(
    //   padding: EdgeInsets.only(
    //     top: 300,
    //   ),
    //   children: getList(),
    //   onReorder: _onReorder,
    // ));
  }

  Widget _buildListTile(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.task_id),
      title: IntrayProductivity(
        title: item.title,
      ),
    );
  }

  Widget _buildReorderableListSimple(
      BuildContext context, List<Task> taskList) {
    return Theme(
        data: ThemeData(
          canvasColor: Colors.transparent,
        ),
        child: ReorderableListView(
          padding: EdgeInsets.only(top: 300.0),
          children: taskList
              .map((Task item) => _buildListTile(context, item))
              .toList(),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              Task item = taskList[oldIndex];
              taskList.remove(item);
              taskList.insert(newIndex, item);
            });
          },
        ));
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Task item = taskList.removeAt(oldIndex);
      taskList.insert(newIndex, item);
    }
  }

  Future<List<Task>> getList() async {
    List<Task> tasks = await tasksBloc.getUserTasks(widget.apiKey);
    return tasks;
  }
}
