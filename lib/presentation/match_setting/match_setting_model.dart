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
    if (match.fileContents[3] == match.fileContents[2]) {
      filemanager.firstServe = false;
    } else {
      filemanager.firstServe = true;
    }
  }
}
