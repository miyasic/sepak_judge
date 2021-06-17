import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepakjudge/domain/assosiations.dart';
import 'package:sepakjudge/exception/generic_exception.dart';

/// ログインしているユーザーを操作する
class AssociationsRepository {
  static AssociationsRepository _instance;
  AssociationsRepository._();
  static AssociationsRepository get instance {
    if (_instance == null) {
      _instance = AssociationsRepository._();
    }
    return _instance;
  }

  final _firestore = FirebaseFirestore.instance;

  /// 一度取得したらメモリキャッシュしておく
  Future<Association> fetch(String associationId) async {
    final doc =
        await _firestore.collection('associations').doc(associationId).get();
    if (!doc.exists) {
      throw GenericException(errorMessages: ['協会アカウントが見つかりませんでした']);
    }
    return Association(doc);
  }
}
