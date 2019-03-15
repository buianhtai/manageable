
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentReference user (uid) {
  return Firestore.instance.collection('users').document(uid);
}