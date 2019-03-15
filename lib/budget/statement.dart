import 'package:cloud_firestore/cloud_firestore.dart';

class Statement {
  final String account;

  final double amount;

  final String currency;

  final String payee;

  final String note;

  final String category;

  final int date;

  final String type;

  final String uid;

  final List<String> tags;

  final DocumentReference reference;

  Statement.fromMap(Map<String, dynamic> map, {this.reference})
      : account = map['account'],
        amount = map['amount'],
        currency = map['currency'],
        payee = map['payee'],
        note = map['note'],
        category = map['category'],
        date = map['date'],
        type = map['type'],
        uid = map['uid'],
        tags = (map['tags'] != null) ? (map['tags'].cast<String>() as List<String>) : Iterable.empty();

  Statement.fromSnapshot(DocumentSnapshot documentSnapshot)
      : this.fromMap(documentSnapshot.data, reference: documentSnapshot.reference);

  @override
  String toString() {
    return '${this.account} ${this.amount} ${this.date} ${this.type}';
  }
}

enum StatementType {
  INCOME,
  EXPENSE
}