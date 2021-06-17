import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepakjudge/domain/competition.dart';

/// 大会に関するレポジトリ
class CompetitionsRepository {
  static CompetitionsRepository _instance;

  CompetitionsRepository._();

  static CompetitionsRepository get instance {
    if (_instance == null) {
      _instance = CompetitionsRepository._();
    }
    return _instance;
  }

  final _firestore = FirebaseFirestore.instance;

  Future<List<Competition>> fetchCompetitions() async {
    final snapshot = await _firestore.collection('competitions').get();
    return snapshot.docs.map((doc) => Competition(doc)).toList();
  }
}
