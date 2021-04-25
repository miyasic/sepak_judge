import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepakjudge/domain/player.dart';
import 'package:sepakjudge/exception/generic_exception.dart';
import 'package:sepakjudge/main.dart';
import 'package:sepakjudge/repository/auth_repository.dart';
import 'package:sepakjudge/repository/player_repository.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

class MyModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final _auth = AuthRepository.instance;
  final _playerRepository = PlayersRepository.instance;
  Player player;

  Future init(context) async {
    isLogin = _auth.isLogin;
    if (isLogin) {
      try {
        player = await _playerRepository.fetch();
      } catch (e) {
        DialogUtils.showSimpleDialog(text: 'アカウントが存在しません。', context: context);
      }
    }
    print(isLogin);
    notifyListeners();
  }

  Future logout() async {
    await _auth.logout();
    isLogin = _auth.isLogin;
    notifyListeners();
  }

  Future signin(context) async {
    final email = emailController.text;
    final pass = passController.text;
    if (email.isEmpty) {
      await DialogUtils.showSimpleDialog(
          text: 'メールアドレスを入力して下さい。', context: context);
      return;
    }
    if (pass.isEmpty) {
      await DialogUtils.showSimpleDialog(
          text: 'パスワードを入力して下さい。', context: context);
      return;
    }

    try {
      await _auth.signIn(email, pass);
      player = await _playerRepository.fetch();
    } catch (e) {
      if (_auth.isLogin) {
        logout();
      }
      DialogUtils.showSimpleDialog(text: e.toString(), context: context);
    } finally {
      isLogin = _auth.isLogin;
      notifyListeners();
    }
  }

  ///テスト用の関数。必要ないのでいいタイミングで消す。
  Future fetchData() async {
    final _firestore = FirebaseFirestore.instance;
    final snapshot = await _firestore
        .collection('associations')
        .doc('0hFSRB2TzCgUevUibxJb7xSzutL2')
        .get();
    final name = snapshot.data()['name'];
    return name;
  }
}
