import 'package:flutter/material.dart';

import '../presentation/final_result/final_result.dart';

class Match extends ChangeNotifier {
  bool server = true; //TeamAがサーブ権を得た場合true,TeamBがサーブ権を得た場合false
  List ServerList = new List.filled(50, false);
  int SetNumber = 1;
//  var ATeamName = FileContentsList[1];
//  var BTeamName = FileContentsList[2];
  var ATeamName = 'RAPORA A';
  var BTeamName = 'TAKTAK A';
  var AScore = [0, 0, 0]; //なぜか配列からTextに出力できない
  var BScore = [0, 0, 0];
  var SetCount = [
    0,
    0,
    0
  ]; //そのセットが行われていなければ０、Ateamがそのセットをとっていたら１、BTeamがそのセットをとっていたら-1
  var APoint = 0;
  var BPoint = 0;
  int count = 0;
  bool side = true;
  bool deuce = false;
  bool ATeamWin = false;
  bool BTeamWin = false;
  int Winner = 0; //Ateamが勝てば１、BTeamが勝てば−１
  bool GameSet = false;
  List ACounter = new List.filled(50, false);
  List BCounter = new List.filled(50, false);

  var NavigationButtonText = 'Push';

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

  //deuceがどうかを判別する関数
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

  //セットの勝利判定をする関数
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

  //ゲームの勝利判定をする関数
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

  //関数
  ifPushACountPoint() {
    ACounter[count] = true;
    BCounter[count] = false;
    count++;
//    setState(() {
    APoint = 0;
    for (var i = 0; i < 49; i++) {
      if (ACounter[i]) {
        APoint++;
      }
    }
    ifDeuce();
    print(deuce);
    server = ServerList[count];
    getWinner();
    if (ATeamWin) print('ATeamwin');
    if (ATeamWin) {
      AScore[SetNumber - 1] = APoint; //setnumberは１〜３
      BScore[SetNumber - 1] = BPoint;
      SetCount[SetNumber - 1] = 1;
      getGameSet();
//      if (GameSet) {
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => FinalResult()));
//      } else {
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => Result()));
//      }
    }
//    });
  }

  ifPushBCountPoint() {
    ACounter[count] = false;
    BCounter[count] = true;
    count++;
//    setState(() {
    BPoint = 0;
    for (var i = 0; i < 49; i++) {
      if (BCounter[i]) {
        BPoint++;
      }
    }
    ifDeuce();
    print(deuce);
    server = ServerList[count];
    getWinner();
    if (BTeamWin) {
      AScore[SetNumber - 1] = APoint; //setnumberは１〜３
      BScore[SetNumber - 1] = BPoint;
      SetCount[SetNumber - 1] = -1;
      getGameSet();
//      if (GameSet) {
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => FinalResult()));
//      } else {
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => Result()));
//      }
    }
//    });
  }

  ifPushReturnButton() {
//    setState(() {
    if (ATeamWin) ATeamWin = false;
    if (BTeamWin) BTeamWin = false;
    if (count > 0) count = count - 1;
    ACounter[count] = false;
    BCounter[count] = false;
    APoint = 0;
    BPoint = 0;
    for (var i = 0; i < 49; i++) {
      if (ACounter[i]) {
        APoint++;
      }
      if (BCounter[i]) {
        BPoint++;
      }
    }
    if (!(APoint > 19 && BPoint > 19)) {
      deuce = false;
    }
    server = ServerList[count];
//    });
  }
}
