import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/player.dart';
import 'package:sepakjudge/domain/teams.dart';
import 'package:sepakjudge/repository/player_repository.dart';
import 'package:sepakjudge/repository/teams_repository.dart';

class TeamSelectModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  final _playerRepository = PlayersRepository.instance;
  List<Team> teams;
  Player player;
  Future init() async {
    teams = await _teamsRepository.fetchTeam();
    player = await _playerRepository.fetch();
    notifyListeners();
  }

  Future applyTeams(teamId) async {
    if (player.teamId != null) {
      throw "もうすでにチームに所属しています。";
    }
    _teamsRepository.applyTeam(teamId, this.player);
  }
}
