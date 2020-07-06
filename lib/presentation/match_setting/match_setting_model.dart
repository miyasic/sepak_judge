import 'package:flutter/material.dart';

class MatchSettingModel extends ChangeNotifier {
  final MatchNameController = TextEditingController();
  final ATeamNameController = TextEditingController();
  final BTeamNameController = TextEditingController();
  final ServiceController = TextEditingController();
  var OutText = '';
  List FileContentsList = ['', '', '', ''];
  var items = ['ATeam', 'BTeam'];
  var firstServe;
}
