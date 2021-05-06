import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/player.dart';
import 'package:sepakjudge/repository/player_repository.dart';
import 'package:sepakjudge/repository/teams_repository.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

class MemberSelectModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  List<Player> members;

  Future init(context) async {
    try {
      //レグ情報
      final _currentUser = await PlayersRepository.instance.fetch();
      members = await _teamsRepository.fetchMembers(_currentUser.teamId);
      print(members);
    } catch (e) {
      DialogUtils.showSimpleDialog(text: e.toString(), context: context);
    }
    notifyListeners();
  }
}
