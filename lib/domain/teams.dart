import 'package:cloud_firestore/cloud_firestore.dart';

/// ユーザー
class Team {
  String teamId;
  String name;
  String email;
  String leader;
  Timestamp createdAt;

  Team(DocumentSnapshot doc) {
    teamId = doc.id;
    name = doc.data()['name'];
    email = doc.data()['email'];
    leader = doc.data()['leader'];
    createdAt = doc.data()['createdAt'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['teamId'] = this.teamId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['leader'] = this.leader;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
