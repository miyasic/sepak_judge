import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/domain/file_manager.dart';
import 'package:sepakjudge/domain/team.dart';

class MatchSettingModel extends ChangeNotifier {
  MatchSettingModel(this.fileManager, {this.inputFileData});
  final FileManager fileManager;
  final inputFileData;
  var match = Match();

  final matchNameController = TextEditingController(text: 'MatchName');
  final aTeamNameController = TextEditingController(text: 'ATeam');
  final bTeamNameController = TextEditingController(text: 'BTeam');
  final serviceController = TextEditingController();
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
      match.assistantReseree = inputFileData[5] ?? '';
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
    }
    notifyListeners();
  }

  void setMatchSetting() {
    match.matchName = matchNameController.text;
    match.aTeamName = aTeamNameController.text;
    match.bTeamName = bTeamNameController.text;
    match.server = serviceController.text == aTeamNameController.text;
    match.timeStart = DateTime.now();
  }

  //最初にサーブ権の配列を埋める関数
  setServer() {
    for (var i = 0; i < 49; i++) {
      if (i == 0) {
        if (match.server == true) {
          match.serverList[i] = true;
        } else {
          match.serverList[i] = false;
        }
      } else if (i < 41) {
        match.serverList[i] = match.serverList[i - 1];
        if (i % 3 == 0) {
          match.serverList[i] = !match.serverList[i];
        }
      } else {
        match.serverList[i] = !match.serverList[i - 1];
      }
    }
  }
}
