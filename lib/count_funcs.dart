import 'package:flutter/material.dart';
import 'package:sepakjudge/point_counting.dart';
import 'package:sepakjudge/match_setting.dart';

//最初にサーブ権の配列を埋める関数
SetServer() {
  for (var i = 0; i < 49; i++) {
    if (i == 0) {
      if (server == true) {
        ServerList[i] = true;
      } else {
        ServerList[i] = false;
      }
    } else if (i < 41) {
      ServerList[i] = ServerList[i - 1];
      if (i % 3 == 0) {
        ServerList[i] = !ServerList[i];
      }
    } else {
      ServerList[i] = !ServerList[i - 1];
    }
  }
}

ifDeuce() {
  if (APoint > 19 && BPoint > 19) {
    if (((APoint - BPoint < 2) && (APoint > BPoint)) ||
        ((BPoint - APoint) < 2 && (BPoint > APoint)) ||
        (APoint == BPoint)) {
      //絶対値をどう描くか
      //得点が等しい時=>deuceではない  得点が等しい時もdeuceにした方が分かりやすいか？
      deuce = true;
    } else {
//      deuce = false;
    }
  }
}

getWinner() {
  if (deuce) {
    if (APoint == 25) {
      ATeamWin = true;
    } else if (BPoint == 25) {
      BTeamWin = true;
    } else if (APoint - BPoint == 2) {
      ATeamWin = true;
    } else if (BPoint - APoint == 2) {
      BTeamWin = true;
    }
  } else if (APoint == 21) {
    ATeamWin = true;
  } else if (BPoint == 21) {
    BTeamWin = true;
  }
}

getGameSet() {
  if (SetCount[0] == SetCount[1]) {
    GameSet = true;
  } else if (SetCount[2] != 0) {
    GameSet = true;
  }
  if (GameSet) {
    if (SetCount[0] + SetCount[1] + SetCount[2] > 0) {
      Winner = 1; //ATeamの勝利
    } else {
      Winner = -1; //BTeamの勝利
    }
  }
}
