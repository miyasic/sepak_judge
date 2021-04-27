import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepakjudge/exception/firebaseauth_exception.dart';
import 'package:sepakjudge/exception/generic_exception.dart';
import 'package:sepakjudge/repository/player_repository.dart';

/// ユーザ認証
class AuthRepository {
  static AuthRepository _instance;
  AuthRepository._();
  static AuthRepository get instance {
    if (_instance == null) {
      _instance = AuthRepository._();
    }
    return _instance;
  }

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// ログイン中Firebaseユーザを返す
  User get firebaseUser => _auth.currentUser;

  /// ログイン中かどうかを返す
  bool get isLogin => _auth.currentUser != null;

  /// ユーザを作成する
  Future signUp(String name, String email, String pass, bool isMale) async {
    try {
      final user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: pass))
          .user;

      _firestore.collection('players').doc(user.uid).set({
        'playerId': user.uid,
        'name': name,
        'email': user.email,
        'isMale': isMale,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      final result = FirebaseAuthExceptionJap.handleException(e);
      throw FirebaseAuthExceptionJap.exceptionMessage(result);
    }
  }

  Future signIn(String email, String pass) async {
    try {
      final user =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return user;
    } catch (e) {
      final result = FirebaseAuthExceptionJap.handleException(e);
      throw FirebaseAuthExceptionJap.exceptionMessage(result);
    }
  }

  /// ログアウトする
  Future logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw GenericException(errorMessages: [e.toString()]);
    }
  }

  /// メールアドレスの変更
  Future updateEmail(String newEmail) async {
    try {
      await firebaseUser.updateEmail(newEmail);
    } catch (e) {
      final result = FirebaseAuthExceptionJap.handleException(e);
      throw FirebaseAuthExceptionJap.exceptionMessage(result);
    }
  }
}
