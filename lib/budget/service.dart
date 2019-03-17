import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manageable/globals.dart' as globals;

final String COLLT = 'statements';

getStatements () async {
  return Firestore.instance.collection(COLLT)
      .where('uid', isEqualTo: globals.email).snapshots();
}

Future<DocumentReference> createStatement(Map<String, dynamic> data) {
  data['uid'] = globals.email;

  return Firestore.instance.collection(COLLT).add(data);
}

Future<void> updateStatement(String path, Map<String, dynamic> data) {
  return Firestore.instance.document(path).updateData(data);
}