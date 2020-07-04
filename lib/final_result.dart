import 'package:flutter/material.dart';
import 'package:sepakjudge/main.dart';
import 'package:sepakjudge/count_funcs.dart';
import 'package:sepakjudge/match_setting.dart';
import 'package:sepakjudge/point_counting.dart';
import 'package:sepakjudge/file_funcs.dart';

var NavigationButtonText = 'Push';

class FinalResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(ATeamName,
                      style: TextStyle(
                        fontSize: 50,
                      )),
                  Text(BTeamName,
                      style: TextStyle(
                        fontSize: 50,
                      )),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                for (int i = 0; i < 3; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '${AScore[i]}',
                        style: Theme.of(context).textTheme.display1,
                      ),
                      Text(
                        "${BScore[i]}",
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
              ],
            ),
            if (Winner == 1)
              Text(
                '$ATeamName WIN',
                style: TextStyle(fontSize: 50),
              ),
            if (Winner == -1)
              Text(
                '$BTeamName WIN',
                style: TextStyle(fontSize: 50),
              ),
            Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text('出力'),
                    onPressed: () {
                      for (int i = 0; i < 3; i++) {
                        OutText =
                            OutText + "," + "${AScore[i]} vs ${BScore[i]}";
                      }
                      outButton();
                    },
                  ),
                  RaisedButton(
                    child: Text('fainl Result'),
                    onPressed: () {
                      share();

                      //変数の初期化
                      ATeamName = 'TeamA';
                      BTeamName = 'TeamB';
                      SetNumber = 1; //何セット目か
                      server = true;
                      for (int i = 0; i < 3; i++) {
                        AScore[i] = 0;
                        BScore[i] = 0;
                        SetCount[i] = 0;
                      }
                      for (int i = 0; i < 49; i++) {
                        ServerList[i] = !ServerList[i]; //サーブ権は１セット目と２セット目で逆
                        ACounter[i] = false;
                        BCounter[i] = false;
                      }
                      APoint = 0;
                      BPoint = 0;
                      count = 0;
                      side = true;
                      deuce = false;
                      ATeamWin = false;
                      BTeamWin = false;
                      Winner = 0;
                      GameSet = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
//                  loadButton();
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => FirstSet()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
