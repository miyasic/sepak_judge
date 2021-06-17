import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/competition.dart';
import 'package:sepakjudge/repository/competitions_repository.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

class SelectCompetitionModel extends ChangeNotifier {
  final _competitionsRepository = CompetitionsRepository.instance;
  List<Competition> competitions;

  Future init(context) async {
    try {
      competitions = await _competitionsRepository.fetchCompetitions();
    } catch (e) {
      DialogUtils.showSimpleDialog(text: e.toString(), context: context);
    }
    notifyListeners();
  }
}
