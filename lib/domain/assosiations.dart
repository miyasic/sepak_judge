import 'package:cloud_firestore/cloud_firestore.dart';

/// 協会
class Association {
  String associationId;
  String name;
  String email;
  Timestamp createdAt;

  Association(DocumentSnapshot doc) {
    associationId = doc.id;
    name = doc.data()['name'];
    email = doc.data()['email'];
    createdAt = doc.data()['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['email'] = this.email;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
