import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manageable/globals.dart' as globals;
import 'package:manageable/core/db.dart' as db;

getStatements () async {
  return db.user(globals.email).collection('statements').snapshots();
}

createStatement(Map<String, dynamic> data) {
  db.user(globals.email).collection('statements').document().setData(data);
}

updateStatement(String path, Map<String, dynamic> data) {
  Firestore.instance.document(path).updateData(data);
}