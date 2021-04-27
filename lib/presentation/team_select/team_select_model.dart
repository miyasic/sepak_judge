import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/teams.dart';
import 'package:sepakjudge/repository/teams_repository.dart';

class TeamSelectModel extends ChangeNotifier {
  final _teamsRepository = TeamsRepository.instance;
  List<Team> teams;
  Future init() async {
    teams = await _teamsRepository.fetchTeam();
    notifyListeners();
  }
}
