import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manageable/globals.dart' as globals;
import 'package:manageable/core/db.dart' as db;

final String COLLT = 'stuffs';

getStuffs (category) async {
  if(category == null) {
    return Firestore.instance.collection(COLLT)
        .where('uid', isEqualTo: globals.email)
        .snapshots();
  }
  return Firestore.instance.collection(COLLT)
      .where('uid', isEqualTo: globals.email)
      .where('category', isEqualTo: category)
      .snapshots();
}

Future<DocumentReference> createStuff(Map<String, dynamic> data) {
  data['uid'] = globals.email;
  return Firestore.instance.collection(COLLT).add(data);
}

Future<void> updateStuff(String path, Map<String, dynamic> data) {
  return Firestore.instance.document(path).updateData(data);
}