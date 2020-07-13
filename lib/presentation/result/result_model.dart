import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';

class ResultModel extends ChangeNotifier {
  ResultModel(this.match);
  final Match match;
  var navigationButtonText = 'NextSet';

  setNextSet() {
    match.setNumber++; //何セット目か
    for (int i = 0; i < 49; i++) {
      match.serverList[i] = !match.serverList[i]; //サーブ権は１セット目と２セット目で逆
      match.aCounter[i] = false;
      match.bCounter[i] = false;
    }
    match.aPoint = 0;
    match.bPoint = 0;
    match.count = 0;
    match.side = !match.side;
    match.deuce = false;
    match.aTeamWin = false;
    match.bTeamWin = false;
    notifyListeners();
  }
}
