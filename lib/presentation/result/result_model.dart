import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';

class ResultModel extends ChangeNotifier {
  final ResultModelMatch = Match(); //これは果たして正しいのか...

  ifPushButton() {
    ResultModelMatch.SetNumber++; //何セット目か
    for (int i = 0; i < 49; i++) {
      ResultModelMatch.ServerList[i] =
          !ResultModelMatch.ServerList[i]; //サーブ権は１セット目と２セット目で逆
      ResultModelMatch.ACounter[i] = false;
      ResultModelMatch.BCounter[i] = false;
    }
    ResultModelMatch.APoint = 0;
    ResultModelMatch.BPoint = 0;
    ResultModelMatch.count = 0;
    ResultModelMatch.side = !ResultModelMatch.side;
    ResultModelMatch.deuce = false;
    ResultModelMatch.ATeamWin = false;
    ResultModelMatch.BTeamWin = false;
    notifyListeners();
  }
}
