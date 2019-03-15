import 'package:flutter/material.dart';
import 'package:manageable/budget/statement.dart';
import 'package:manageable/budget/add.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

typedef StatementRowDeleteAction = void Function(Statement statement);

typedef ReloadAction = void Function();

class StatementListRow extends StatefulWidget {
  final Statement statement;

  final StatementRowDeleteAction deleteAction;

  const StatementListRow({Key key, this.statement, this.deleteAction}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatementListRowState(statement, deleteAction);
  }
}

class StatementListRowState extends State<StatementListRow> {
  final Statement statement;
  final StatementRowDeleteAction deleteAction;

  StatementListRowState(this.statement, this.deleteAction);

  bool showActionButton = false;

  VoidCallback _getDeleteHandler(StatementRowDeleteAction callback) {
    return callback == null ? null : () => callback(statement);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      delegate: SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                  title: Text('${statement.category}'),
                  subtitle: Text('${statement.note}')
              ),
            ),
            Expanded(
                child: Center(
                  child: Text(statement.account),
                )
            ),
            Expanded(
                child: Container(
                  child:
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(statement.amount.toString(),
                          style: TextStyle(
                              color: (statement.type == StatementType.INCOME.toString()) ? Colors.green : Colors.red
                          ),
                        ),
                      ]
                  ),
                )
            )
          ],
        ),
        Divider(height: 5.0),
      ]),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Edit',
            color: Colors.black45,
            icon: Icons.edit,
            onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StatementAddWidget(statement: statement))
            ).then((value) {
              //reloadAction();
            })
            }
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _getDeleteHandler(deleteAction),
        ),
      ],
    );
  }
}