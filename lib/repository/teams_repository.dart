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

  final _auth = AuthRepository.instance;
  final _firestore = FirebaseFirestore.instance;
//
//  /// 団体情報（ここで保持することでメモリキャッシュしている）
//  Team _team;
//
//  /// 団体を返す
//  /// 一度取得したらメモリキャッシュしておく
//  Future<Team> fetch() async {
//    if (_team == null) {
//      final id = _auth.firebaseUser?.uid;
//      if (id == null) {
//        return null;
//      }
//      final doc = await _firestore.collection('teams').doc(id).get();
//      if (!doc.exists) {
//        throw GenericException(errorMessages: ['団体アカウントが見つかりませんでした']);
//      }
//      _team = Team(doc);
//    }
//    return _team;
//  }

  Future<List<String>> fetchTeamNames() async {
    final QuerySnapshot snapshot = await _firestore.collection('teams').get();
    final List<DocumentSnapshot> docs = snapshot.docs;
    docs.map((doc) => print(doc.id));
//    return docs.map((doc) => doc.).toList();
  }

  Future<List<Team>> fetchTeam() async {
    final snapshot = await _firestore.collection('teams').get();
    return snapshot.docs.map((doc) => Team(doc)).toList();
  }

  /// 団体に所属の申請をする。
  Future applyTeam(teamId, Player player) async {
    _firestore
        .collection('teams')
        .doc(teamId)
        .collection('members')
        .doc(player.playerId)
        .set({
      'playerId': player.playerId,
      'name': player.name,
      'email': player.email,
      'teamId': teamId,
      'isMale': player.isMale,
      'isApproved': false,
      'createdAt': DateTime.now(),
    });
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
