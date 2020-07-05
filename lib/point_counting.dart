import 'package:flutter/material.dart';
import 'package:sepakjudge/count_funcs.dart';
import 'package:sepakjudge/match_setting.dart';
import 'package:sepakjudge/result.dart';
import 'package:sepakjudge/final_result.dart';

//branchを作成した。
bool server = true; //TeamAがサーブ権を得た場合true,TeamBがサーブ権を得た場合false
List ServerList = new List.filled(50, false);
int SetNumber = 1;
var ATeamName = FileContentsList[1];
var BTeamName = FileContentsList[2];
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

class PointCounting extends StatefulWidget {
  @override
  State createState() {
    //画面遷移後に読み込まれるviewdidload的な感じ
    server = firstServe;
    for (int i = 0; i < SetNumber + 1; i++) {
      server = !server;
    }
    SetServer();
    return _PointCountingState();
  }
}

class _PointCountingState extends State<PointCounting> {
  ifPushACountPoint() {
    ACounter[count] = true;
    BCounter[count] = false;
    count++;
    setState(() {
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
        if (GameSet) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FinalResult()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Result()));
        }
      }
    });
  }

  ifPushBCountPoint() {
    ACounter[count] = false;
    BCounter[count] = true;
    count++;
    setState(() {
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
        if (GameSet) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FinalResult()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Result()));
        }
      }
    });
  }

  ifPushReturnButton() {
    setState(() {
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
    });
  }

  Widget counting() {
    if (side) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (server)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(ATeamName,
                      style: TextStyle(
                        fontSize: 50,
                      )),
                  Text(BTeamName,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black12,
                      )),
                ],
              ),
            if (!server)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(ATeamName,
                      style: TextStyle(fontSize: 40, color: Colors.black12)),
                  Text(BTeamName,
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.black,
                      )),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  '$APoint',
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  "$BPoint",
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text(ATeamName),
                  onPressed: () {
                    ifPushACountPoint();
                  },
                ),
                RaisedButton(
                  child: Text(BTeamName),
                  onPressed: () {
                    ifPushBCountPoint();
                  },
                ),
              ],
            ),
            //以下コートチェンジ

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('return'),
                  onPressed: () {
                    ifPushReturnButton();
                  },
                ),
                RaisedButton(
                  child: Text('SideChange'),
                  onPressed: () {
                    setState(() {
                      side = !side;
                      print(side);
                    });
                  },
                ),
              ],
            )
          ],
        ),
      );
    }
    if (!side) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (server)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(BTeamName,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black12,
                      )),
                  Text(ATeamName,
                      style: TextStyle(
                        fontSize: 50,
                      )),
                ],
              ),
            if (!server)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(BTeamName,
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.black,
                      )),
                  Text(ATeamName,
                      style: TextStyle(fontSize: 40, color: Colors.black12)),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "$BPoint",
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  '$APoint',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text(BTeamName),
                  onPressed: () {
                    ifPushBCountPoint();
                  },
                ),
                RaisedButton(
                  child: Text(ATeamName),
                  onPressed: () {
                    ifPushACountPoint();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('return'),
                  onPressed: () {
                    ifPushReturnButton();
                  },
                ),
                RaisedButton(
                  child: Text('SideChange'),
                  onPressed: () {
                    setState(() {
                      side = !side;
                      print(side);
                    });
                  },
                ),
              ],
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (SetNumber == 1) {
      return Scaffold(
        appBar: AppBar(
          title: Text('1st'),
        ),
        body: counting(),
      );
    }
    if (SetNumber == 2) {
      return Scaffold(
        appBar: AppBar(
          title: Text('2nd'),
        ),
        body: counting(),
      );
    }
    if (SetNumber == 3) {
      return Scaffold(
        appBar: AppBar(
          title: Text('3rd'),
        ),
        body: counting(),
      );
    }
  }
}
