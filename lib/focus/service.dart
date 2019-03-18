import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manageable/globals.dart' as globals;

final String COLLT = 'tasks';

getTasks (category) async {
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

Future<DocumentReference> createTask(Map<String, dynamic> data) {
  data['uid'] = globals.email;
  return Firestore.instance.collection(COLLT).add(data);
}

Future<void> updateTask(String path, Map<String, dynamic> data) {
  return Firestore.instance.document(path).updateData(data);
}