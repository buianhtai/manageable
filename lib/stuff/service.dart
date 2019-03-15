import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manageable/globals.dart' as globals;
import 'package:manageable/core/db.dart' as db;

getStuffs () async {
  return db.user(globals.email).collection('stuffs').snapshots();
}

createStuff(Map<String, dynamic> data) {
  db.user(globals.email).collection('stuffs').document().setData(data);
}

updateStuff(String path, Map<String, dynamic> data) {
  Firestore.instance.document(path).updateData(data);
}