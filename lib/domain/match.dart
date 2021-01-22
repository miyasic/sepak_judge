import 'package:sepakjudge/domain/team.dart';

class Match {
  String matchName = 'MatchName';
  bool server = true; //TeamAがサーブ権を得た場合true,TeamBがサーブ権を得た場合false
  List serverList = new List.filled(50, false);
  int setNumber = 1;
  var aTeamName = 'ATeam';
  var bTeamName = 'BTeam';
  var aScore = [0, 0, 0]; //なぜか配列からTextに出力できない
  var bScore = [0, 0, 0];
  var setCount = [
    0,
    0,
    0
  ]; //そのセットが行われていなければ０、Ateamがそのセットをとっていたら１、BTeamがそのセットをとっていたら-1
  var aPoint = 0;
  var bPoint = 0;
  int count = 0;
  bool side = true;
  bool deuce = false;
  bool aTeamWin = false;
  bool bTeamWin = false;
  int winner = 0; //Ateamが勝てば１、BTeamが勝てば−１
  bool gameSet = false;
  List aCounter = new List.filled(50, false);
  List bCounter = new List.filled(50, false);

  DateTime timeStart;
  DateTime timeEnd;

  Team aTeam = Team(name: 'ATeam');
  Team bTeam = Team(name: 'BTeam');
  String courtName;
  String chiefReferee;
  String assistantReferee;
  bool fileInput = false;

  //deuceがどうかを判別する関数
  setIfDeuce() {
    if (aPoint > 19 && bPoint > 19) {
      if (((aPoint - bPoint < 2) && (aPoint > bPoint)) ||
          ((bPoint - aPoint) < 2 && (bPoint > aPoint)) ||
          (aPoint == bPoint)) {
        //絶対値をどう描くか
        //得点が等しい時=>deuceではない  得点が等しい時もdeuceにした方が分かりやすいか？
        deuce = true;
      }
    }
  }

  //最初にサーブ権の配列を埋める関数
  setServer() {
    for (var i = 0; i < 49; i++) {
      if (i == 0) {
        if (server == true) {
          serverList[i] = true;
        } else {
          serverList[i] = false;
        }
      } else if (i < 41) {
        serverList[i] = serverList[i - 1];
        if (i % 3 == 0) {
          serverList[i] = !serverList[i];
        }
      } else {
        serverList[i] = !serverList[i - 1];
      }
    }
  }

  //セットの勝利判定をする関数
  checkWinner() {
    if (deuce) {
      if (aPoint == 25) {
        aTeamWin = true;
      } else if (bPoint == 25) {
        bTeamWin = true;
      } else if (aPoint - bPoint == 2) {
        aTeamWin = true;
      } else if (bPoint - aPoint == 2) {
        bTeamWin = true;
      }
    } else if (aPoint == 21) {
      aTeamWin = true;
    } else if (bPoint == 21) {
      bTeamWin = true;
    }
  }

  //ゲームの勝利判定をする関数
  checkGameSet() {
    if (setCount[0] == setCount[1]) {
      gameSet = true;
    } else if (setCount[2] != 0) {
      gameSet = true;
    }
    if (gameSet) {
      if (setCount[0] + setCount[1] + setCount[2] > 0) {
        winner = 1; //ATeamの勝利
      } else {
        winner = -1; //BTeamの勝利
      }
    }
  }

  String getOutPutText() {
    String output = matchName +
        ',' +
        aTeamName +
        ',' +
        bTeamName +
        ',' +
        (server ? aTeamName : bTeamName);
    if (fileInput) {
      //ATeamの選手名、背番号
      for (int i = 0; i < aTeam.members.length; i++) {
        output += ',' + aTeam.members[i].name + ',' + aTeam.members[i].number;
      }
      output += ',' + aTeam.captain;
      //BTeamの選手名、背番号
      for (int i = 0; i < bTeam.members.length; i++) {
        output += ',' + bTeam.members[i].name + ',' + bTeam.members[i].number;
      }
      output += ',' + bTeam.captain;
    }
    output += '\n';
    //以下試合結果
    //勝利チーム
    output += (winner == 1 ? aTeamName : bTeamName);
    //得点とセットカウント
    for (int i = 0; i < 3; i++) {
      output += "," + "${aScore[i]} vs ${bScore[i]}";
    }
    output += ',' + getSetCount();
    return output;
  }

  String getSetCount() {
    int setCountSum = setCount.reduce((value, element) => value + element);
    if (setCountSum == 2) {
      return '2 vs 0';
    } else if (setCountSum == 1) {
      return '2 vs 1';
    } else if (setCountSum == -1) {
      return '1 vs 2';
    } else if (setCountSum == -2) {
      return '0 vs 2';
    } else {
      return 'セットカウントが計算できませんでした。';
    }
  }
}
