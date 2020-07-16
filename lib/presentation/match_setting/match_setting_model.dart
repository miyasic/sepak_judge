import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';

class MatchSettingModel extends ChangeNotifier {
  final match = Match();
  final matchNameController = TextEditingController(text: 'MatchName');
  final aTeamNameController = TextEditingController(text: 'ATeam');
  final bTeamNameController = TextEditingController(text: 'BTeam');
  final serviceController = TextEditingController();
  var teamName = ['ATeam', 'BTeam'];
  var firstServe;

  void setTeamName() {
    match.aTeamName = aTeamNameController.text;
    match.bTeamName = bTeamNameController.text;
  }

  void setFileContents() {
    match.fileContents[0] = matchNameController.text;
    match.fileContents[1] = aTeamNameController.text;
    match.fileContents[2] = bTeamNameController.text;
    match.fileContents[3] = serviceController.text;
  }

  void setFirstServe() {
    if (match.fileContents[3] == match.fileContents[2]) {
      firstServe = false;
    } else {
      firstServe = true;
    }
  }
}
