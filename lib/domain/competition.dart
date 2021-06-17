import 'package:cloud_firestore/cloud_firestore.dart';

class Competition {
  String competitionId;
  String name;
  String division;
  String stadium;
  DateTime entryDeadline;
  int competitionDays;
  DateTime competitionDate;
  String associationId;
  bool isPublic;
  DateTime createdAt;

  Competition(DocumentSnapshot doc) {
    competitionId = doc.id;
    name = doc.data()['name'];
    division = doc.data()['division'];
    stadium = doc.data()['stadium'];
    entryDeadline = doc.data()['entryDeadline'].toDate();
    competitionDays = doc.data()['competitionDays'];
    competitionDate = doc.data()['competitionDate'].toDate();
    associationId = doc.data()['associationId'];
    isPublic = doc.data()['isPublic'];
    createdAt = doc.data()['createdAt'].toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['name'] = this.name;
    data['division'] = this.division;
    data['stadium'] = this.stadium;
    data['entryDeadline'] = this.entryDeadline;
    data['competitionDays'] = this.competitionDays;
    data['competitionDate'] = this.competitionDate;
    data['associationId'] = this.associationId;
    data['isPublic'] = this.isPublic;
    data['createdAt'] = this.createdAt;
  }
}
