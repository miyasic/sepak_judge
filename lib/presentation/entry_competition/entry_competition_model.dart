import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/assosiations.dart';
import 'package:sepakjudge/domain/competition.dart';
import 'package:sepakjudge/domain/player.dart';
import 'package:sepakjudge/domain/regu.dart';
import 'package:sepakjudge/repository/associaiton_repository.dart';
import 'package:sepakjudge/repository/player_repository.dart';
import 'package:sepakjudge/repository/teams_repository.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

import '../../constants.dart';

class EntryCompetitionModel extends ChangeNotifier {
  EntryCompetitionModel(this.competition);
  final Competition competition;
  List<DateTime> competitionDates;

  final _associationRepository = AssociationsRepository.instance;
  final _reguRepository = TeamsRepository.instance;
  final _playerRepository = PlayersRepository.instance;
  Association association;
  List<Player> members;
  List<List> playerNameControllerList = [
    [TextEditingController(text: '1人目'), TextEditingController()],
    [TextEditingController(text: '2人目'), TextEditingController()],
    [TextEditingController(text: '3人目'), TextEditingController()],
  ];
  final captainController = TextEditingController();
  int captainPickerIndex = 0;
  Regu regu;

  Future init(context) async {
    try {
      competitionDates = getCompetitionDates();
      association =
          await _associationRepository.fetch(competition.associationId);
      final Player _currentUser = await _playerRepository.fetch();
      members = await _reguRepository.fetchMembers(_currentUser.teamId);
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

  void addPlayer() {
    int x = this.playerNameControllerList.length + 1;
    if (x < 7) {
      this
          .playerNameControllerList
          .add([TextEditingController(text: '$x人目'), TextEditingController()]);
      this.regu.members.add(ReguMembers());
    }
    onChangedReguInfo('');
    notifyListeners();
  }

  void deletePlayer() {
    if (this.playerNameControllerList.length > 3) {
      this.playerNameControllerList.removeLast();
      this.regu.members.removeLast();
    }
    onChangedReguInfo('');
    notifyListeners();
  }

  void onChangedReguInfo(String text) {
    for (int i = 0; i < playerNameControllerList.length; i++) {
      regu.members[i].name = playerNameControllerList[i][0].text;
      regu.members[i].number = playerNameControllerList[i][1].text;
    }
//    regu.name = reguNameController.text;
    regu.captain = captainController.text;
  }

  void showCaptainPicker(
    context,
  ) {
    final _pickerItems = regu.members.map((item) => Text(item.name)).toList();

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: themeSecondBackColor,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              scrollController:
                  FixedExtentScrollController(initialItem: captainPickerIndex),
              itemExtent: 32,
              children: _pickerItems,
              onSelectedItemChanged: (int index) {
                captainPickerIndex = index;
                captainController.text = regu.members[captainPickerIndex].name;
              },
            ),
          ),
        );
      },
    );
  }
}
