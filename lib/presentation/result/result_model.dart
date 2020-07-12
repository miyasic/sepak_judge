import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';

class ResultModel extends ChangeNotifier {
  ResultModel(this.match);
  final Match match;
  var navigationButtonText = 'NextSet';

  setNextSet() {
    match.SetNumber++; //何セット目か
    for (int i = 0; i < 49; i++) {
      match.ServerList[i] = !match.ServerList[i]; //サーブ権は１セット目と２セット目で逆
      match.ACounter[i] = false;
      match.BCounter[i] = false;
    }
    match.APoint = 0;
    match.BPoint = 0;
    match.count = 0;
    match.side = !match.side;
    match.deuce = false;
    match.ATeamWin = false;
    match.BTeamWin = false;
    notifyListeners();
  }
}
