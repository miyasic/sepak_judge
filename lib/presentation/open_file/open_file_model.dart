import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sepakjudge/domain/file_manager.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/domain/team.dart';

class OpenFileModel extends ChangeNotifier {
  OpenFileModel(this.filemanager);
  final match = Match();
  final FileManager filemanager;
  List<String> inputFileData;

  Future setMatchSettings(fileName) async {
    final text = await filemanager.getFileData(fileName);
    inputFileData = text.split(',');

    if (inputFileData[1] != null && inputFileData[2] != null) {
      match.aTeam.name = checkNoData(inputFileData[1]);
      match.bTeam.name = checkNoData(inputFileData[2]);
    }
    match.courtName = checkNoData(inputFileData[3]);
    match.chiefReferee = checkNoData(inputFileData[4]);
    match.assistantReferee = checkNoData(inputFileData[5]);
    for (int i = 0; i < 6; i++) {
      Player player = Player();
      player.name = checkNoData(inputFileData[6 + 2 * i]);
      player.number = checkNoData(inputFileData[7 + 2 * i]);
      match.aTeam.members.add(player);
    }
    match.aTeam.captain = checkNoData(inputFileData[18]);
    for (int i = 0; i < 6; i++) {
      Player player = Player();
      player.name = checkNoData(inputFileData[19 + 2 * i]);
      player.number = checkNoData(inputFileData[20 + 2 * i]);
      match.bTeam.members.add(player);
    }
    match.bTeam.captain = checkNoData(inputFileData[31]);
  }

  String checkNoData(String input) {
    if (input == 'NODATA') {
      return '';
    } else {
      return input;
    }
  }
}
