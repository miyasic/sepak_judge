import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepakjudge/domain/player.dart';
import 'package:sepakjudge/domain/teams.dart';
import 'auth_repository.dart';

/// ログインしている団体を操作する
class TeamsRepository {
  static TeamsRepository _instance;

  TeamsRepository._();

  static TeamsRepository get instance {
    if (_instance == null) {
      _instance = TeamsRepository._();
    }
    return _instance;
  }

  final _firestore = FirebaseFirestore.instance;

  Future<Team> fetchTeam(String teamId) async {
    final snapshot = await _firestore.collection('teams').doc(teamId).get();
    return Team(snapshot);
  }

  Future<List<Team>> fetchTeams() async {
    final snapshot = await _firestore.collection('teams').get();
    return snapshot.docs.map((doc) => Team(doc)).toList();
  }

  /// 団体に所属の申請をする。
  Future applyTeam(teamId, Player player) async {
    final batch = _firestore.batch();

    final forTeamDoc = _firestore
        .collection('teams')
        .doc(teamId)
        .collection('members')
        .doc(player.playerId);
    batch.set(forTeamDoc, {
      'playerId': player.playerId,
      'name': player.name,
      'email': player.email,
      'teamId': teamId,
      'isMale': player.isMale,
      'isApproved': false,
      'createdAt': DateTime.now(),
    });

    final forPlayerDoc = _firestore.collection('players').doc(player.playerId);
    batch.set(forPlayerDoc, {
      'teamId': teamId,
      'isApproved': false,
    });
    batch.commit();
  }

//  /// 団体をアップデートする
//  Future updateTeam(Team team) {
//    FirebaseFirestore.instance
//        .collection('teams')
//        .doc(_team.teamId)
//        .update(_team.toJson());
//  }
//
//  /// 団体のメンバーを取得する
//  Future<List<Player>> fetchMembers(String teamId) async {
//    final snapshot = await _firestore
//        .collection('teams')
//        .doc(teamId)
//        .collection('members')
//        .get();
//    return snapshot.docs.map((doc) => Player(doc)).toList();
//  }
//
//  Future approveMember(String playerId) async {
//    _firestore
//        .collection('teams')
//        .doc(_team.teamId)
//        .collection('members')
//        .doc(playerId)
//        .update({
//      'isApproved': true,
//    });
//  }
}
