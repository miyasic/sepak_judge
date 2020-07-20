import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  Future<String> getText(fileName) async {
    final text = await filemanager.getFileData(fileName);
    return text;
  }
}
