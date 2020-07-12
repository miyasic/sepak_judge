import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';

class MatchSettingModel extends ChangeNotifier {
  final match = Match();
  final matchNameController = TextEditingController(text: 'MatchName');
  final ATeamNameController = TextEditingController(text: 'Ateam');
  final BTeamNameController = TextEditingController(text: 'Bteam');
  final ServiceController = TextEditingController();
  var TeamName = ['ATeam', 'BTeam'];
  var firstServe;

  void setTeamName() {
    match.ATeamName = ATeamNameController.text;
    match.BTeamName = BTeamNameController.text;
  }

  void setFileContents() {
    match.fileContents[0] = matchNameController.text;
    match.fileContents[1] = ATeamNameController.text;
    match.fileContents[2] = BTeamNameController.text;
    match.fileContents[3] = ServiceController.text;
  }

  void setFirstServe() {
    if (match.fileContents[3] == match.fileContents[2]) {
      firstServe = false;
    } else {
      firstServe = true;
    }
  }
}
