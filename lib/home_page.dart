import 'package:flutter/material.dart';
import 'package:manageable/home_menu.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Manageable'),
      ),
      drawer: HomeMenu(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            makeDashboardItem('My Stuffs', Icons.branding_watermark, Colors.pinkAccent, '/stuffs'),
            makeDashboardItem('Budget Tracker', Icons.attach_money, Colors.green, '/budget'),
            makeDashboardItem('Focus', Icons.remove_red_eye, Colors.blue, '/focus'),
            makeDashboardItem('Notebooks', Icons.note, Colors.yellow, '/notebooks')
          ],
        ),
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon, Color color, String route) {
    return Card(
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          //decoration: BoxDecoration(color: Color(0xb5d4ce)),
          child: InkWell(
            onTap: () {
              Navigator.popAndPushNamed(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: color,
                    )),
                SizedBox(height: 20.0),
                Center(
                  child: Text(title,
                      style:
                      TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}