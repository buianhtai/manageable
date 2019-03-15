import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:manageable/budget/statement.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_tags/input_tags.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:manageable/budget/constants.dart';
import 'package:manageable/common/constants.dart';
import 'package:manageable/budget/service.dart' as service;


class StatementAddWidget extends StatefulWidget {
  final StatementType type;
  final Statement statement;

  const StatementAddWidget({Key key, this.type, this.statement}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatementAddWidgetState(type, statement);
  }
}

class StatementAddWidgetState extends State<StatementAddWidget> {
  StatementType type;
  Statement statement;

  final _amountTextController = TextEditingController();
  final _noteTextController = TextEditingController();

  String _currency = 'VND';
  String _account = 'Cash';
  String _category;

  DateTime _date = DateTime.now();
  List<String> _tags = [];

  StatementAddWidgetState(this.type, this.statement);

  @override
  void initState() {
    super.initState();

    if(this.statement != null) {
      _currency = this.statement.currency;
      type = StatementType.values.firstWhere((statementType) => statementType.toString() == this.statement.type);
      _amountTextController.text = this.statement.amount.toString();
      _currency = this.statement.currency;
      _category = this.statement.category;
      print(this.statement.date);
      _date = DateTime.fromMillisecondsSinceEpoch(this.statement.date);
      _noteTextController.text = this.statement.note;
      _tags = this.statement.tags;
    }
    else {
      _category = (type == StatementType.EXPENSE) ? 'Food' : 'Business Life';
    }
  }

  @override
  Widget build(BuildContext context) {
    //var config = AppConfig.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('New statement'),
        leading: CloseButton(),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              var data = {
                'type': type.toString(),
                'account': _account,
                'amount': double.parse(_amountTextController.text),
                'currency': _currency,
                'category': _category,
                'note': _noteTextController.text,
                'date': _date.millisecondsSinceEpoch,
                'tags': _tags,
              };

              if(this.statement == null) {
                service.createStatement(data);
              } else {
                print('update statement ' + statement.reference.path);
                service.updateStatement(statement.reference.path, data);
              }

              Navigator.pop(context, null);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.attach_money),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: '0.00'
                    ),
                    keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                    controller: _amountTextController,
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: DropdownButton<String>(
                      items: CURRENCIES.map((c) => DropdownMenuItem<String>(
                        value: '$c',
                        child: Text('$c'),
                      )).toList(),
                      value: _currency,
                      onChanged: _onCurrencyChange,
                    )
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: TextField(
                    decoration: InputDecoration(
                        hintText: 'If you want to add a note'
                    ),
                    controller: _noteTextController,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_balance),
                  title: DropdownButton<String>(
                    items: ACCOUNTS.map((c) => DropdownMenuItem<String>(
                      value: '$c',
                      child: Text('$c'),
                    )).toList(),
                    value: _account,
                    onChanged: _onAccountTypeChange,
                  )
                ),
                ListTile(
                    leading: Icon(Icons.category),
                    title: type == StatementType.EXPENSE
                        ? DropdownButton<String>(
                            items: EXPENSE_CATEGORIES.map((c) => DropdownMenuItem<String>(
                              value: '$c',
                              child: Text('$c'),
                            )).toList(),
                            value: _category,
                            onChanged: _onCategoryChange,)
                        : DropdownButton<String>(
                            items: INCOME_CATEGORIES.map((c) => DropdownMenuItem<String>(
                              value: '$c',
                              child: Text('$c'),
                            )).toList(),
                            value: _category,
                            onChanged: _onCategoryChange,
                        )
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: DateTimePickerFormField(
                    format: DateFormat(DATE_FORMAT),
                    initialValue: _date,
                    dateOnly: true,
                    onChanged: (d) {
                      _date = d;
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.label),
                  title: InputTags(
                    tags: _tags,
                    onDelete: (tag){
                      print(tag);
                    },
                    onInsert: (tag){
                      print(tag);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
//      bottomNavigationBar: BottomNavigationBar(
//        items: <BottomNavigationBarItem>[
//          BottomNavigationBarItem(icon: Icon(Icons.cancel), title: Text('Cancle'), backgroundColor: Colors.red),
//          BottomNavigationBarItem(icon: Icon(Icons.save), title: Text('Save'), backgroundColor: Colors.green),
//        ],
//      ),
    );
  }

  void _onCurrencyChange(String selectedCurrency) {
    setState(() {
      _currency = selectedCurrency;
    });
  }

  void _onCategoryChange(String selectedCategory) {
    setState(() {
      _category = selectedCategory;
    });
  }

  void _onAccountTypeChange(String selectedAccount) {
    setState(() {
      _account = selectedAccount;
    });
  }

}