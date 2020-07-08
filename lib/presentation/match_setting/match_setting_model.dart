import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';

class MatchSettingModel extends ChangeNotifier {
  final match = Match();
  final MatchNameController = TextEditingController(text: 'MatchName');
  final ATeamNameController = TextEditingController(text: 'Ateam');
  final BTeamNameController = TextEditingController(text: 'Bteam');
  final ServiceController = TextEditingController();
  var OutText = '';
  List FileContentsList = ['', '', '', ''];
  var items = ['ATeam', 'BTeam'];
  var firstServe;
}
