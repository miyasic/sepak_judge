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
    match.aTeamName = 'TeamA';
    match.bTeamName = 'TeamB';
    match.setNumber = 1; //何セット目か
    match.server = true;
    for (int i = 0; i < 3; i++) {
      match.aScore[i] = 0;
      match.bScore[i] = 0;
      match.setCount[i] = 0;
    }
    for (int i = 0; i < 49; i++) {
      match.serverList[i] = !match.serverList[i]; //サーブ権は１セット目と２セット目で逆
      match.aCounter[i] = false;
      match.bCounter[i] = false;
    }
    match.aPoint = 0;
    match.bPoint = 0;
    match.count = 0;
    match.side = true;
    match.deuce = false;
    match.aTeamWin = false;
    match.bTeamWin = false;
    match.winner = 0;
    match.gameSet = false;
  }
}
