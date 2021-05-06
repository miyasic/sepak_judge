import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/assosiations.dart';
import 'package:sepakjudge/domain/competition.dart';
import 'package:sepakjudge/domain/player.dart';
import 'package:sepakjudge/repository/associaiton_repository.dart';
import 'package:sepakjudge/repository/player_repository.dart';
import 'package:sepakjudge/repository/teams_repository.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

class EntryCompetitionModel extends ChangeNotifier {
  EntryCompetitionModel(this.competition);
  final Competition competition;
  List<DateTime> competitionDates;

  final _associationRepository = AssociationsRepository.instance;
  final _teamRepository = TeamsRepository.instance;
  final _playerRepository = PlayersRepository.instance;
  Association association;
  List<Player> members;

  Future init(context) async {
    try {
      competitionDates = getCompetitionDates();
      association =
          await _associationRepository.fetch(competition.associationId);
      final Player _currentUser = await _playerRepository.fetch();
      members = await _teamRepository.fetchMembers(_currentUser.teamId);
      print(members.length);
      print(members[0].name);
    } catch (e) {
      DialogUtils.showSimpleDialog(text: e.toString(), context: context);
    }
    notifyListeners();
  }

  List<DateTime> getCompetitionDates() {
    List<DateTime> dates = [];
    for (int i = 0; i < competition.competitionDays; i++) {
      dates.add(competition.competitionDate.add(Duration(days: i)));
    }
    return dates;
  }
}
