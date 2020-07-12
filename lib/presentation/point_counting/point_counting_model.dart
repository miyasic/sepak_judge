import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';

class PointCountingModel extends ChangeNotifier {
  PointCountingModel(this.match);
  final Match match;

  //関数
  ifPushACountPoint() {
    match.aCounter[match.count] = true;
    match.bCounter[match.count] = false;
    match.count++;
    match.aPoint = 0;
    for (var i = 0; i < 49; i++) {
      if (match.aCounter[i]) {
        match.aPoint++;
      }
    }
    match.setIfDeuce();
    match.server = match.serverList[match.count];
    match.checkWinner();
    if (match.aTeamWin) print('ATeamwin');
    if (match.aTeamWin) {
      match.aScore[match.setNumber - 1] = match.aPoint; //setnumberは１〜３
      match.bScore[match.setNumber - 1] = match.bPoint;
      match.setCount[match.setNumber - 1] = 1;
      match.checkGameSet();
    }
    notifyListeners();
  }

  ifPushBCountPoint() {
    match.aCounter[match.count] = false;
    match.bCounter[match.count] = true;
    match.count++;
    match.bPoint = 0;
    for (var i = 0; i < 49; i++) {
      if (match.bCounter[i]) {
        match.bPoint++;
      }
    }
    match.setIfDeuce();
    match.server = match.serverList[match.count];
    match.checkWinner();
    if (match.bTeamWin) {
      match.aScore[match.setNumber - 1] = match.aPoint; //setnumberは１〜３
      match.bScore[match.setNumber - 1] = match.bPoint;
      match.setCount[match.setNumber - 1] = -1;
      match.checkGameSet();
    }
    notifyListeners();
  }

  ifPushReturnButton() {
    if (match.aTeamWin) match.aTeamWin = false;
    if (match.bTeamWin) match.bTeamWin = false;
    if (match.count > 0) match.count = match.count - 1;
    match.aCounter[match.count] = false;
    match.bCounter[match.count] = false;
    match.aPoint = 0;
    match.bPoint = 0;
    for (var i = 0; i < 49; i++) {
      if (match.aCounter[i]) {
        match.aPoint++;
      }
      if (match.bCounter[i]) {
        match.bPoint++;
      }
    }
    if (!(match.aPoint > 19 && match.bPoint > 19)) {
      match.deuce = false;
    }
    match.server = match.serverList[match.count];
    notifyListeners();
  }

  ifPushSideChangeButton() {
    match.side = !match.side;
    notifyListeners();
  }
}
