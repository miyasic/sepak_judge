import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/domain/file_manager.dart';

class MatchSettingModel extends ChangeNotifier {
  MatchSettingModel(this.fileManager);
  final FileManager fileManager;
  var match = Match();

  void setTeamName() {
    match.aTeamName = fileManager.aTeamNameController.text;
    match.bTeamName = fileManager.bTeamNameController.text;
  }

  void setFileContents() {
    match.fileContents[0] = fileManager.matchNameController.text;
    match.fileContents[1] = fileManager.aTeamNameController.text;
    match.fileContents[2] = fileManager.bTeamNameController.text;
    match.fileContents[3] = fileManager.serviceController.text;
  }

  void setFirstServe() {
    if (match.fileContents[3] == match.fileContents[2]) {
      match.server = false;
    } else {
      match.server = true;
    }
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
