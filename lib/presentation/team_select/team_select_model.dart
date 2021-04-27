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
  String playerTeamName;
  Future init() async {
    teams = await _teamsRepository.fetchTeams();
    player = await _playerRepository.fetch();
    getPlayerTeamName();
    notifyListeners();
  }

  void getPlayerTeamName() {
    for (final team in teams) {
      if (team.teamId == player.teamId) {
        playerTeamName = team.name;
        break;
      }
    }
  }

  Future applyTeams(teamId) async {
    if (player.teamId != null) {
      throw "もうすでにチームに所属しています。";
    }
    _teamsRepository.applyTeam(teamId, this.player);
    player.isApproved = false;
    player.teamId = teamId;
    _playerRepository.updateLocalPlayer(player);
  }

  Future changeTeams(newTeamId) async {
    String oldTeamId = player.teamId;
    _teamsRepository.changeTeam(newTeamId, oldTeamId, this.player);
    player.isApproved = false;
    player.teamId = newTeamId;
    _playerRepository.updateLocalPlayer(player);
  }
}
