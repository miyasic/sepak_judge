import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepakjudge/domain/player.dart';

class Regu {
  Regu({name, members});
  String name = '';
  List<ReguMembers> members = [];
  String captain = '';
  bool isInputCompleted = false;
}

class ReguMembers {
  ReguMembers({this.name, this.number});
  String name = '';
  String number = '';
}

class ReguFireStore {
  String reguId;
  String name;
  int order;
  int numMember;
  List<String> memberIds;
  String captainId;
  DateTime createdAt;

  Regu(DocumentSnapshot doc) {
    reguId = doc.id;
    name = doc.data()['name'];
    order = doc.data()['order'];
    memberIds = doc.data()['memberIds'];
    createdAt = doc.data()['createdAt'];
  }

  setMemberIds(String playerId) {
    memberIds = [playerId, '', ''];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['reguId'] = this.reguId;
    data['name'] = this.name;
    data['order'] = this.order;
    data['memberIds'] = this.memberIds;
    data['captainId'] = this.captainId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
