import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepakjudge/domain/player.dart';
import 'package:sepakjudge/exception/generic_exception.dart';
import 'auth_repository.dart';

/// 選手の情報を操作する
class PlayersRepository {
  static PlayersRepository _instance;
  PlayersRepository._();
  static PlayersRepository get instance {
    if (_instance == null) {
      _instance = PlayersRepository._();
    }
    return _instance;
  }

  final _auth = AuthRepository.instance;
  final _firestore = FirebaseFirestore.instance;

  /// ユーザー情報（ここで保持することでメモリキャッシュしている）
  Player _player;

  /// ユーザーを返す
  /// 一度取得したらメモリキャッシュしておく
  Future<Player> fetch() async {
    if (_player == null) {
      final id = _auth.firebaseUser?.uid;
      if (id == null) {
        return null;
      }
      final doc = await _firestore.collection('players').doc(id).get();
      if (!doc.exists) {
        throw GenericException(errorMessages: ['協会アカウントが見つかりませんでした']);
      }
      _player = Player(doc);
    }
    return _player;
  }

  /// ユーザーをアップデートする
  Future updatePlayer(Player player) async {
    FirebaseFirestore.instance
        .collection('players')
        .doc(_player.playerId)
        .update(player.toJson());
  }
}
