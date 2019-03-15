import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:intl/intl.dart';
import 'package:manageable/common/constants.dart';
import 'package:manageable/stuff/constants.dart';
import 'package:manageable/stuff/stuff.dart';
import 'package:flutter/foundation.dart';
import 'package:manageable/stuff/service.dart' as service;

class StuffEdit extends StatefulWidget {
  final Stuff stuff;

  const StuffEdit({Key key, this.stuff}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StuffEditState(stuff);
  }
}

class StuffEditState extends State<StuffEdit> {
  final _formKey = GlobalKey<FormState>();

  Stuff stuff;

  final _titleTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  String _currency = 'VND';
  String _category = 'Clothing';

  DateTime _boughtDate = DateTime.now();
  DateTime _lastUsed = DateTime.now();
  List<String> _tags = [];

  StuffEditState(this.stuff);

  @override
  void initState() {
    super.initState();

    if(this.stuff != null) {
      _titleTextController.text = this.stuff.title;
      _descriptionTextController.text = this.stuff.description;
      _priceTextController.text = this.stuff.price.toString();
      _currency = this.stuff.currency;
      _category = this.stuff.category;
      _boughtDate = DateTime.fromMillisecondsSinceEpoch(this.stuff.boughtDate);
      _tags = this.stuff.tags;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stuff == null ? 'New stuff' : stuff.title),
        leading: CloseButton(),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              var data = {
                'title': _titleTextController.text,
                'description': _descriptionTextController.text,
                'category': _category,
                'price': double.parse(_priceTextController.text),
                'currency': _currency,
                'boughtDate': _boughtDate.millisecondsSinceEpoch,
                'tags': _tags,
              };

              if(this.stuff == null) {
                service.createStuff(data);
              } else {
                print('updated stuff ' + stuff.reference.path);
                service.updateStuff(stuff.reference.path, data);
              }

              Navigator.pop(context, null);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: new EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Title'
                  ),
                  controller: _titleTextController,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Description'
                  ),
                  controller: _descriptionTextController,
                ),
                DropdownButton<String>(
                  items: CATEGORIES.map((c) => DropdownMenuItem<String>(
                    value: '$c',
                    child: Text('$c'),
                  )).toList(),
                  value: _category,
                  onChanged: _onCategoryChange,
                ),
                DateTimePickerFormField(
                  format: DateFormat(DATE_FORMAT),
                  decoration: InputDecoration(
                    labelText: 'Bought date'
                  ),
                  initialValue: _boughtDate,
                  dateOnly: true,
                  onChanged: (d) {
                    _boughtDate = d;
                  },
                ),
                DateTimePickerFormField(
                  format: DateFormat(DATE_FORMAT),
                  decoration: InputDecoration(
                      labelText: 'Last used'
                  ),
                  initialValue: _lastUsed,
                  dateOnly: true,
                  onChanged: (d) {
                    _lastUsed = d;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: '0.00',
                      labelText: 'Price',
                  ),
                  keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                  controller: _priceTextController,
                ),
                DropdownButton<String>(
                  items: CURRENCIES.map((c) => DropdownMenuItem<String>(
                    value: '$c',
                    child: Text('$c'),
                  )).toList(),
                  value: _currency,
                  onChanged: _onCurrencyChange,
                ),
                InputTags(
                  tags: _tags,
                  onDelete: (tag){
                    print(tag);
                  },
                  onInsert: (tag){
                    print(tag);
                  },
                ),
              ],
            ),
          )
        )
      )
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
}