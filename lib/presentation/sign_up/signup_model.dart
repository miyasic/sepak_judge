import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepakjudge/repository/auth_repository.dart';
import 'package:sepakjudge/repository/player_repository.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

class SignupModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isMale;

  final _auth = AuthRepository.instance;
  final _playerRepository = PlayersRepository.instance;
  Future SignUp(context, completion) async {
    final name = nameController.text;
    final email = emailController.text;
    final pass = passController.text;
    if (name.isEmpty) {
      await DialogUtils.showAlertDialog(
          text: '名前を入力して下さい。', context: context, completion: completion);
      return;
    }
    if (email.isEmpty) {
      await DialogUtils.showAlertDialog(
          text: 'メールアドレスを入力して下さい。', context: context, completion: completion);
      return;
    }
    if (pass.isEmpty) {
      await DialogUtils.showAlertDialog(
          text: 'パスワードを入力して下さい。', context: context, completion: completion);
      return;
    }
    if (isMale == null) {
      await DialogUtils.showAlertDialog(
          text: '性別をチェックして下さい', context: context, completion: completion);
    }

    try {
      await _auth.signUp(name, email, pass, isMale);
    } catch (e) {
      DialogUtils.showSimpleDialog(text: e.toString(), context: context);
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

  void changeRadioButton(value) {
    isMale = value;
    notifyListeners();
  }
}
