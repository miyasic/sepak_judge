import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/file_manager.dart';
import 'package:sepakjudge/domain/match.dart';

class OpenFileModel extends ChangeNotifier {
  OpenFileModel(this.filemanager);
  final FileManager filemanager;
  final match = Match();
  final matchNameController = TextEditingController(text: 'MatchName');
  final aTeamNameController = TextEditingController(text: 'ATeam');
  final bTeamNameController = TextEditingController(text: 'BTeam');
  final serviceController = TextEditingController();
  var teamName = ['ATeam', 'BTeam'];
  var firstServe;

  void fileset() async {
    await filemanager.setInputFileName();
    await print(filemanager.inputFileNames);
    notifyListeners();
  }
}
