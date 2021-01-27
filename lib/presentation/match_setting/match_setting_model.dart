import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/domain/file_manager.dart';
import 'package:sepakjudge/domain/team.dart';

import '../../constants.dart';

class MatchSettingModel extends ChangeNotifier {
  MatchSettingModel(this.fileManager, {this.inputFileData});
  final FileManager fileManager;
  final inputFileData;
  var match = Match();

  final matchNameController = TextEditingController(text: 'MatchName');
  final aTeamNameController = TextEditingController(text: 'ATeam');
  final bTeamNameController = TextEditingController(text: 'BTeam');
  final serviceController = TextEditingController();
  int servicePickerIndex = 0;
  List<String> teamName = ['ATeam', 'BTeam'];

  void init() {
    if (inputFileData != null) {
      if (inputFileData[0] != null) matchNameController.text = inputFileData[0];
      if (inputFileData[1] != null && inputFileData[2] != null) {
        aTeamNameController.text = inputFileData[1];
        bTeamNameController.text = inputFileData[2];
        match.aTeam.name = inputFileData[1];
        match.bTeam.name = inputFileData[2];
        teamName = [inputFileData[1], inputFileData[2]];
      }
      match.courtName = inputFileData[3] ?? '';
      match.chiefReferee = inputFileData[4] ?? '';
      match.assistantReferee = inputFileData[5] ?? '';
      for (int i = 0; i < 6; i++) {
        Player player = Player();
        player.name = inputFileData[6 + 2 * i] ?? '';
        player.number = inputFileData[7 + 2 * i] ?? '';
        match.aTeam.members.add(player);
      }
      match.aTeam.captain = inputFileData[18] ?? '';
      for (int i = 0; i < 6; i++) {
        Player player = Player();
        player.name = inputFileData[19 + 2 * i] ?? '';
        player.number = inputFileData[20 + 2 * i] ?? '';
        match.bTeam.members.add(player);
      }
      match.bTeam.captain = inputFileData[31] ?? '';
    } else {
      match.aTeam.name = 'ATeam';
      match.bTeam.name = 'BTeam';
      match.aTeam.members = [
        Player(name: '1人目', number: '1'),
        Player(name: '2人目', number: '2'),
        Player(name: '3人目', number: '3'),
        Player(name: ''),
        Player(name: ''),
        Player(name: '')
      ];
      match.bTeam.members = [
        Player(name: '1人目', number: '1'),
        Player(name: '2人目', number: '2'),
        Player(name: '3人目', number: '3'),
        Player(name: ''),
        Player(name: ''),
        Player(name: '')
      ];
      print(match.aTeam.members[1].name);
    }
    notifyListeners();
  }

  void setMatchSetting() {
    match.matchName = matchNameController.text;
    match.aTeamName = aTeamNameController.text;
    match.bTeamName = bTeamNameController.text;
    match.server = !(serviceController.text == bTeamNameController.text);
    match.setServer();
    match.timeStart = DateTime.now();
  }

  Future<void> showServicePicker(
    context,
  ) async {
    final _pickerItems = teamName.map((item) => Text(item)).toList();

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
                  FixedExtentScrollController(initialItem: servicePickerIndex),
              itemExtent: 32,
              children: _pickerItems,
              onSelectedItemChanged: (int index) {
                servicePickerIndex = index;
                serviceController.text = teamName[servicePickerIndex];
              },
            ),
          ),
        );
      },
    );
  }
}
