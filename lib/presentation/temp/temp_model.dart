import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TempModel extends ChangeNotifier {
  Future fetchData() async {
    final _firestore = FirebaseFirestore.instance;
    final snapshot = await _firestore
        .collection('associations')
        .doc('0hFSRB2TzCgUevUibxJb7xSzutL2')
        .get();
    final name = snapshot.data()['name'];
    return name;
  }
}
