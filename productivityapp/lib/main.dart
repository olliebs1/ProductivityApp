import 'package:flutter/material.dart';
import 'package:productivityapp/UI/Intray/Login/Loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/global.dart';
import 'UI/Intray/intray_page.dart';
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
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getApiKey(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String apiKey = '';
        if (snapshot.hasData) {
          apiKey = snapshot.data;
        } else {
          print('no data');
        }
        // apiKey.length > 0 ? getHomePage() :
        return apiKey.length > 0 ? getHomePage() : LoginPage();
      },
    );
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('API_Token');
  }

  Widget getHomePage() {
    return MaterialApp(
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: new Scaffold(
            body: Stack(
              children: <Widget>[
                TabBarView(
                  children: [
                    IntrayPage(),
                    new Container(
                      color: Colors.orange,
                    ),
                    new Container(
                      color: Colors.lightGreen,
                    ),
                    new Container(
                      child: Center(
                        child: FlatButton(
                          child: Text('Log Out.'),
                          onPressed: () {},
                        ),
                      ),
                      color: Colors.red,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 50),
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Intray", style: intrayTitleStyle),
                        Container()
                      ]),
                ),
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(
                      top: 100, left: MediaQuery.of(context).size.width * 0.40),
                  child: FloatingActionButton(
                    child: Icon(Icons.add, size: 50),
                    backgroundColor: redColor,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
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
                  Tab(
                    icon: new Icon(Icons.settings),
                  )
                ],
                labelColor: darkGreyColor,
                unselectedLabelColor: darkGreyColor,
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

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_Token', '');
  }

  @override
  void initState() {
    super.initState();
  }
}
