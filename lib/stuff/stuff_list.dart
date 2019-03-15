import 'package:flutter/material.dart';
import 'package:manageable/stuff/stuff.dart';
import 'package:manageable/stuff/row.dart';
import 'package:random_string/random_string.dart' as random;

class StuffList extends StatelessWidget {
  final List<Stuff> stuffs;
  final StuffRowActionCallback onOpen;

  const StuffList({Key key, this.stuffs, this.onOpen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(stuffs);
    return Container(
      child: ListView.builder(
          itemCount: stuffs.length,
          key: Key(random.randomAlphaNumeric(10)),
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return StuffRow(
              stuff: stuffs[position],
              onPressed: onOpen,
            );
          }
      )
    );
  }
}