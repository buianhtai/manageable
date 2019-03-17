import 'package:cloud_firestore/cloud_firestore.dart';

class Stuff {
  final String title;
  final String description;
  final String category;
  final int boughtDate;
  final double price;
  final String currency;
  final String thumbnail;
  final String picture;
  final List<String> tags;
  final String uid;
  final DocumentReference reference;

  Stuff.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        description = map['description'],
        category = map['category'],
        boughtDate = map['boughtDate'],
        price = map['price'],
        currency = map['currency'],
        uid = map['uid'],
        thumbnail = map['thumbnail'],
        picture = map['picture'],
        tags = (map['tags'] != null) ? (map['tags'].cast<String>() as List<String>) : Iterable.empty();

  Stuff.fromSnapshot(DocumentSnapshot documentSnapshot)
      : this.fromMap(documentSnapshot.data, reference: documentSnapshot.reference);

  @override
  String toString() {
    return '${this.title} ${this.description}';
  }
}