import 'package:flutter/material.dart';
import 'package:manageable/budget/statement.dart';
import 'package:flutter/foundation.dart';
import 'package:manageable/budget/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manageable/budget/add.dart';
import 'package:manageable/budget/row.dart';
import 'package:random_string/random_string.dart' as random;
import 'package:manageable/budget/service.dart' as service;


class BudgetHomePage extends StatefulWidget {
  BudgetHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BudgetHomeState();
}

class BudgetHomeState extends State<BudgetHomePage> {
  int _selectedIndex = 0;
  var statementStream;

  @override
  void initState() {
    super.initState();

    service.getStatements().then((result) {
      setState(() {
        statementStream = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
        actions: <Widget>[
          Opacity(
            opacity: _selectedIndex == 0 ? 1 : 0,
            child: IconButton(icon: Icon(Icons.add), iconSize: 30,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatementAddWidget(type: StatementType.INCOME))
                );
              },
            ),
          ),
          Opacity(
            opacity: _selectedIndex == 0 ? 1 : 0,
            child: IconButton(icon: Icon(Icons.remove), iconSize: 30,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatementAddWidget(type: StatementType.EXPENSE))
                );
              },
            ),
          ),
        ],
      ),
      drawer: BudgetMenu(),
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance), title: Text('Accounts')),
            BottomNavigationBarItem(icon: Icon(Icons.pie_chart), title: Text('Statistics')),
          ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onBottomBarItemTapped,
      ),
    );
  }

  _buildBody(BuildContext context) {
    // var config = AppConfig.of(context);
    if(_selectedIndex == 0) {
      return StreamBuilder<QuerySnapshot> (
        stream: statementStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          var statements = snapshot.data.documents.map((snap) => Statement.fromSnapshot(snap)).toList();
          return _buildList(context, statements);
        },
      );
    }
    else if (_selectedIndex == 1) {
      return ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Saving Account'),
              Text('Cash Account')
            ],
          )
        ],
      ) ;
    } else {
      return Container(
        child: Text("Charts"),
      );
    }
  }

  void _onBottomBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _refresh() {
    service.getStatements().then((result) {
      setState(() {
        statementStream = result;
      });
    });
  }

  void _onDelete(Statement statement) {
    setState(() {
      print('deleted ');
      statement.reference.delete();
      _refresh();
    });
  }

  Widget _buildList(BuildContext context, List<Statement> statements) {
    return ListView.builder(
        key: Key(random.randomAlphaNumeric(10)),
        itemCount: statements.length,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, position) {
          return _buildListItem(context, statements[position]);
        });
      //padding: const EdgeInsets.all(20.0),
      //children: statements.map((Statement d) => _buildListItem(context, d)).toList(),
    //);
  }

  Widget _buildListItem(BuildContext context, Statement statement) {
    return StatementListRow(statement: statement, deleteAction: _onDelete);
  }
}