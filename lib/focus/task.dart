
import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String title;
  final double stars;
  final int estimatedTime; // in minutes
  final String notes;
  final DocumentReference reference;

  Task.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        stars = map['stars'] as double,
        estimatedTime = map['estimatedTime'],
        notes = map['notes'];

  Task.fromSnapshot(DocumentSnapshot documentSnapshot)
      : this.fromMap(documentSnapshot.data, reference: documentSnapshot.reference);

  @override
  String toString() {
    return '${this.title} ${this.stars}';
  }
}