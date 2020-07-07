import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';

class PointCountingModel extends ChangeNotifier {
  final PointCountingModelMatch = Match();
  //関数
  ifPushACountPoint() {
//    PointCountingModelMatch.ATeamName = "";
    PointCountingModelMatch.SetServer(); //本当は一回だけ実行したい
    PointCountingModelMatch.ACounter[PointCountingModelMatch.count] = true;
    PointCountingModelMatch.BCounter[PointCountingModelMatch.count] = false;
    PointCountingModelMatch.count++;
    PointCountingModelMatch.APoint = 0;
    for (var i = 0; i < 49; i++) {
      if (PointCountingModelMatch.ACounter[i]) {
        PointCountingModelMatch.APoint++;
      }
    }
    PointCountingModelMatch.ifDeuce();
    print(PointCountingModelMatch.deuce);
    PointCountingModelMatch.server =
        PointCountingModelMatch.ServerList[PointCountingModelMatch.count];
    PointCountingModelMatch.getWinner();
    if (PointCountingModelMatch.ATeamWin) print('ATeamwin');
    if (PointCountingModelMatch.ATeamWin) {
      PointCountingModelMatch.AScore[PointCountingModelMatch.SetNumber - 1] =
          PointCountingModelMatch.APoint; //setnumberは１〜３
      PointCountingModelMatch.BScore[PointCountingModelMatch.SetNumber - 1] =
          PointCountingModelMatch.BPoint;
      PointCountingModelMatch.SetCount[PointCountingModelMatch.SetNumber - 1] =
          1;
      PointCountingModelMatch.getGameSet();
    }
    notifyListeners();
  }

  ifPushBCountPoint() {
    PointCountingModelMatch.SetServer(); //本当は一回だけ実行したい
    PointCountingModelMatch.ACounter[PointCountingModelMatch.count] = false;
    PointCountingModelMatch.BCounter[PointCountingModelMatch.count] = true;
    PointCountingModelMatch.count++;
    PointCountingModelMatch.BPoint = 0;
    for (var i = 0; i < 49; i++) {
      if (PointCountingModelMatch.BCounter[i]) {
        PointCountingModelMatch.BPoint++;
      }
    }
    PointCountingModelMatch.ifDeuce();
    print(PointCountingModelMatch.deuce);
    PointCountingModelMatch.server =
        PointCountingModelMatch.ServerList[PointCountingModelMatch.count];
    PointCountingModelMatch.getWinner();
    if (PointCountingModelMatch.BTeamWin) {
      PointCountingModelMatch.AScore[PointCountingModelMatch.SetNumber - 1] =
          PointCountingModelMatch.APoint; //setnumberは１〜３
      PointCountingModelMatch.BScore[PointCountingModelMatch.SetNumber - 1] =
          PointCountingModelMatch.BPoint;
      PointCountingModelMatch.SetCount[PointCountingModelMatch.SetNumber - 1] =
          -1;
      PointCountingModelMatch.getGameSet();
    }
    notifyListeners();
  }

  ifPushReturnButton() {
    if (PointCountingModelMatch.ATeamWin)
      PointCountingModelMatch.ATeamWin = false;
    if (PointCountingModelMatch.BTeamWin)
      PointCountingModelMatch.BTeamWin = false;
    if (PointCountingModelMatch.count > 0)
      PointCountingModelMatch.count = PointCountingModelMatch.count - 1;
    PointCountingModelMatch.ACounter[PointCountingModelMatch.count] = false;
    PointCountingModelMatch.BCounter[PointCountingModelMatch.count] = false;
    PointCountingModelMatch.APoint = 0;
    PointCountingModelMatch.BPoint = 0;
    for (var i = 0; i < 49; i++) {
      if (PointCountingModelMatch.ACounter[i]) {
        PointCountingModelMatch.APoint++;
      }
      if (PointCountingModelMatch.BCounter[i]) {
        PointCountingModelMatch.BPoint++;
      }
    }
    if (!(PointCountingModelMatch.APoint > 19 &&
        PointCountingModelMatch.BPoint > 19)) {
      PointCountingModelMatch.deuce = false;
    }
    PointCountingModelMatch.server =
        PointCountingModelMatch.ServerList[PointCountingModelMatch.count];
    notifyListeners();
  }

  ifPushSideChangeButton() {
    PointCountingModelMatch.side = !PointCountingModelMatch.side;
    notifyListeners();
  }
}
