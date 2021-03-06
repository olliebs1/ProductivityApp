import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:productivityapp/UI/Intray/Login/Loginscreen.dart';
import 'package:productivityapp/bloc/blocs/resources/repository.dart';
import 'UI/Intray/intray_page.dart';
import 'models/global.dart';
import 'package:http/http.dart' as http;
import 'package:productivityapp/models/classes/user.dart';
import 'package:productivityapp/bloc/blocs/user_blocs_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Productivity App',
        theme: ThemeData(
            primarySwatch: Colors.grey,
            dialogBackgroundColor: Colors.transparent),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskBloc tasksBloc;
  String apiKey = "";
  Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: signinUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          apiKey = snapshot.data;
          tasksBloc = TaskBloc(apiKey);
        } else {
          print("No data");
        }
        return apiKey.length > 0
            ? getHomePage()
            : LoginPage(
                login: login,
                newUser: false,
              );
      },
    );
  }

  void login() {
    setState(() {
      build(context);
    });
  }

  Future signinUser() async {
    String userName = "";
    apiKey = await getApiKey();
    if (apiKey != null) {
      if (apiKey.length > 0) {
        userBloc.signinUser("", "", apiKey);
      } else {
        print("No api key");
      }
    } else {
      apiKey = "";
    }
    return apiKey;
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("API_Token");
  }

  Widget getHomePage() {
    return MaterialApp(
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(children: <Widget>[
              TabBarView(
                children: [
                  IntrayPage(
                    apiKey: apiKey,
                  ),
                  new Container(
                    color: Colors.orange,
                  ),
                  new Container(
                    child: Center(
                      child: FlatButton(
                        color: redColor,
                        child: Text("Log out"),
                        onPressed: () {
                          logout();
                        },
                      ),
                    ),
                    color: Colors.lightGreen,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 50),
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Intray",
                      style: intrayTitleStyle,
                    ),
                    Container()
                  ],
                ),
              ),
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(
                    top: 120,
                    left: MediaQuery.of(context).size.width * 0.5 - 40),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    size: 70,
                  ),
                  backgroundColor: redColor,
                  onPressed: _showAddDialog,
                ),
              )
            ]),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.rss_feed),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                ],
                labelColor: darkGreyColor,
                unselectedLabelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showAddDialog() {
    TextEditingController taskName = new TextEditingController();
    TextEditingController taskDeadline = new TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              padding: EdgeInsets.all(10),
              width: 500,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                color: darkGreyColor,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Add New Task',
                      style: whiteTitle,
                    ),
                    Container(
                      child: TextField(
                        controller: taskName,
                        decoration: InputDecoration(
                          hintText: 'New Task',
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.4)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    Container(
                      child: TextField(
                        controller: taskDeadline,
                        decoration: InputDecoration(
                          hintText: 'Deadline',
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.4)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: redColor,
                          child: Text(
                            'Cancel',
                            style: whiteButtonTitle,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        RaisedButton(
                          color: redColor,
                          child: Text(
                            'Add',
                            style: whiteButtonTitle,
                          ),
                          onPressed: () {
                            if (taskName.text != null) {
                              addTask(taskName.text, taskDeadline.text);
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    )
                  ])),
        );
      },
    );
  }

  void addTask(String taskName, String taskDeadline) async {
    print(taskName + taskDeadline + apiKey);
    await _repository.addUserTask(apiKey, taskName, taskDeadline);
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_Token', '');
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
