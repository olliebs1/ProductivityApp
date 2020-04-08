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
        home: LoginPage()
        // FutureBuilder(
        //     future: getUser(), // a previously-obtained Future<String> or null
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       if (snapshot.connectionState == ConnectionState.none &&
        //           snapshot.hasData == null) {
        //         return Container();
        //       }
        //       return ListView.builder(
        //         itemCount: snapshot.data.length,
        //         itemBuilder: (context, index) {
        //           return Column(
        //             children: <Widget>[],
        //           );
        //         },
        //       );
        //     }),
        );
  }

  Future getUser() async {
    var result = await http.get('http://127.0.0.1:5000/api/register');
    print(result.body);
    return result;
    // String apiKey = await getApiKey();
    // if (apiKey.length <= 0) {
    // } else {}
  }

  asyncFunc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  Future<String> getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey;
    try {
      apiKey = prefs.getString('API_Token');
    } catch (exception) {
      apiKey = '';
    }
    return apiKey;
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
    bloc.registerUser("ollierwqe", "ollwqeerie", "ollqweerie", "123reqwe",
        "ollieerr qeqw@gmail.com");
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
}
