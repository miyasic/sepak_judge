import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  String playerId;
  String name;
  String email;
  String teamId;
  bool sex; //女性が0男性が1
  bool isApproved;
  Timestamp createdAt;

  Player(DocumentSnapshot doc) {
    playerId = doc.id;
    name = doc.data()['name'];
    email = doc.data()['email'];
    teamId = doc.data()['teamId'];
    sex = doc.data()['sex'];
    isApproved = doc.data()['isApproved'];
    createdAt = doc.data()['createdAt'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['playerId'] = this.playerId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['teamId'] = this.teamId;
    data['sex'] = this.sex;
    data['isApproved'] = this.isApproved;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
