import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepakjudge/main.dart';
import 'package:sepakjudge/presentation/my_page/my_page.dart';
import 'package:sepakjudge/repository/auth_repository.dart';
import 'package:sepakjudge/repository/player_repository.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

class SignupModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isMale;
  bool isLoading = false;

  final _auth = AuthRepository.instance;

  Future SignUp(context) async {
    final name = nameController.text;
    final email = emailController.text;
    final pass = passController.text;
    if (name.isEmpty) {
      await DialogUtils.showSimpleDialog(text: '名前を入力して下さい。', context: context);
      return;
    }
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
    if (isMale == null) {
      await DialogUtils.showSimpleDialog(
          text: '性別をチェックして下さい', context: context);
    }

    try {
      await _auth.signUp(name, email, pass, isMale);
      isLogin = _auth.isLogin;
      Navigator.pop(context, isLogin);
    } catch (e) {
      DialogUtils.showSimpleDialog(text: e.toString(), context: context);
    }
  }

  void changeRadioButton(value) {
    isMale = value;
    notifyListeners();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }
}
