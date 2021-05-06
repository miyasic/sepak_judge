import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/competition.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

class EntryCompetitionModel extends ChangeNotifier {
  EntryCompetitionModel(this.competition);
  final Competition competition;
  List<DateTime> competitionDates;

  Future init(context) async {
    try {
      competitionDates = getCompetitionDates();
      print(competition.competitionDays);
    } catch (e) {
      DialogUtils.showSimpleDialog(text: e.toString(), context: context);
    }
    notifyListeners();
  }

  List<DateTime> getCompetitionDates() {
    List<DateTime> dates = [];
    for (int i = 0; i < competition.competitionDays; i++) {
      dates.add(competition.competitionDate.add(Duration(days: i)));
    }
    return dates;
  }
}
