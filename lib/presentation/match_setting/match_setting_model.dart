import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/domain/file_manager.dart';

class MatchSettingModel extends ChangeNotifier {
  MatchSettingModel(this.filemanager);
  final FileManager filemanager;
  final match = Match();

  void setTeamName() {
    match.aTeamName = filemanager.aTeamNameController.text;
    match.bTeamName = filemanager.bTeamNameController.text;
  }

  void setFileContents() {
    match.fileContents[0] = filemanager.matchNameController.text;
    match.fileContents[1] = filemanager.aTeamNameController.text;
    match.fileContents[2] = filemanager.bTeamNameController.text;
    match.fileContents[3] = filemanager.serviceController.text;
  }

  void setFirstServe() {
    print(match.fileContents[2]);
    print(match.fileContents[3]);
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
