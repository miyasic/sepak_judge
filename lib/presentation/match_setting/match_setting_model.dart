import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/domain/regu.dart';

import '../../constants.dart';

class MatchSettingModel extends ChangeNotifier {
  MatchSettingModel();
  var match = Match();

  final matchNameController = TextEditingController(text: 'MatchName');
  final aTeamNameController = TextEditingController(text: 'ATeam');
  final bTeamNameController = TextEditingController(text: 'BTeam');
  final serviceController = TextEditingController();
  int servicePickerIndex = 0;
  List<String> teamName = ['ATeam', 'BTeam'];

  void init() {
    match.aTeam.name = 'ATeam';
    match.bTeam.name = 'BTeam';
    match.aTeam.members = [
      ReguMembers(name: '1人目', number: '1'),
      ReguMembers(name: '2人目', number: '2'),
      ReguMembers(name: '3人目', number: '3'),
      ReguMembers(name: ''),
      ReguMembers(name: ''),
      ReguMembers(name: '')
    ];
    match.bTeam.members = [
      ReguMembers(name: '1人目', number: '1'),
      ReguMembers(name: '2人目', number: '2'),
      ReguMembers(name: '3人目', number: '3'),
      ReguMembers(name: ''),
      ReguMembers(name: ''),
      ReguMembers(name: '')
    ];
    print(match.aTeam.members[1].name);
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

  void showServicePicker(context) {
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
