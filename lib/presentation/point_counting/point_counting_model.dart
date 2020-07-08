import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting_page.dart';

class PointCountingModel extends ChangeNotifier {
  PointCountingModel(this.match);
  final Match match;

  //関数
  ifPushACountPoint() {
//    PointCountingModelMatch.ATeamName = "";
    match.SetServer(); //本当は一回だけ実行したい
    match.ACounter[match.count] = true;
    match.BCounter[match.count] = false;
    match.count++;
    match.APoint = 0;
    for (var i = 0; i < 49; i++) {
      if (match.ACounter[i]) {
        match.APoint++;
      }
    }
    match.ifDeuce();
    print(match.deuce);
    match.server = match.ServerList[match.count];
    match.getWinner();
    if (match.ATeamWin) print('ATeamwin');
    if (match.ATeamWin) {
      match.AScore[match.SetNumber - 1] = match.APoint; //setnumberは１〜３
      match.BScore[match.SetNumber - 1] = match.BPoint;
      match.SetCount[match.SetNumber - 1] = 1;
      match.getGameSet();
    }
    notifyListeners();
  }

  ifPushBCountPoint() {
    match.SetServer(); //本当は一回だけ実行したい
    match.ACounter[match.count] = false;
    match.BCounter[match.count] = true;
    match.count++;
    match.BPoint = 0;
    for (var i = 0; i < 49; i++) {
      if (match.BCounter[i]) {
        match.BPoint++;
      }
    }
    match.ifDeuce();
    print(match.deuce);
    match.server = match.ServerList[match.count];
    match.getWinner();
    if (match.BTeamWin) {
      match.AScore[match.SetNumber - 1] = match.APoint; //setnumberは１〜３
      match.BScore[match.SetNumber - 1] = match.BPoint;
      match.SetCount[match.SetNumber - 1] = -1;
      match.getGameSet();
    }
    notifyListeners();
  }

  ifPushReturnButton() {
    if (match.ATeamWin) match.ATeamWin = false;
    if (match.BTeamWin) match.BTeamWin = false;
    if (match.count > 0) match.count = match.count - 1;
    match.ACounter[match.count] = false;
    match.BCounter[match.count] = false;
    match.APoint = 0;
    match.BPoint = 0;
    for (var i = 0; i < 49; i++) {
      if (match.ACounter[i]) {
        match.APoint++;
      }
      if (match.BCounter[i]) {
        match.BPoint++;
      }
    }
    if (!(match.APoint > 19 && match.BPoint > 19)) {
      match.deuce = false;
    }
    match.server = match.ServerList[match.count];
    notifyListeners();
  }

  ifPushSideChangeButton() {
    match.side = !match.side;
    notifyListeners();
  }
}
