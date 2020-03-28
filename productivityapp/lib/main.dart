import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'models/global.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productivity App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Productivity App'),
    );
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
                    new Container(
                      color: darkGreyColor,
                    ),
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
                    child: Container(
                      child: Icon(Icons.add, size: 50),
                    ),
                    backgroundColor: Colors.red,
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
