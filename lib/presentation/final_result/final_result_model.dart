//import 'package:flutter/material.dart';
//
//class FinalResultModel extends ChangeNotifier {
//  FinalResultModel(this.match);
//  final Match match;
//}
import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';

class FinalResultModel extends ChangeNotifier {
  FinalResultModel(this.match);
  final Match match;

  setNextMatch() {
    //変数の初期化
    match.ATeamName = 'TeamA';
    match.BTeamName = 'TeamB';
    match.SetNumber = 1; //何セット目か
    match.server = true;
    for (int i = 0; i < 3; i++) {
      match.AScore[i] = 0;
      match.BScore[i] = 0;
      match.SetCount[i] = 0;
    }
    for (int i = 0; i < 49; i++) {
      match.ServerList[i] = !match.ServerList[i]; //サーブ権は１セット目と２セット目で逆
      match.ACounter[i] = false;
      match.BCounter[i] = false;
    }
    match.APoint = 0;
    match.BPoint = 0;
    match.count = 0;
    match.side = true;
    match.deuce = false;
    match.ATeamWin = false;
    match.BTeamWin = false;
    match.Winner = 0;
    match.GameSet = false;
  }
}
