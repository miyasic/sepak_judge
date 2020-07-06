//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:sepakjudge/presentation/point_counting/point_counting.dart';
//import 'package:sepakjudge/count_funcs.dart';
//import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
//
//var NavigationButtonText = 'Push';
//
//class Result extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text('result'),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  if (ATeamWin) Text(ATeamName, style: TextStyle(fontSize: 40)),
//                  if (!ATeamWin)
//                    Text(ATeamName,
//                        style: TextStyle(fontSize: 40, color: Colors.black38)),
//                  if (BTeamWin) Text(BTeamName, style: TextStyle(fontSize: 40)),
//                  if (!BTeamWin)
//                    Text(BTeamName,
//                        style: TextStyle(fontSize: 40, color: Colors.black38)),
//                ],
//              ),
//            ),
//            Column(
//              children: <Widget>[
//                for (int i = 0; i < 3; i++)
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Text(
//                        '${AScore[i]}',
//                        style: Theme.of(context).textTheme.display1,
//                      ),
//                      Text(
//                        "${BScore[i]}",
//                        style: Theme.of(context).textTheme.display1,
//                      ),
//                    ],
//                  ),
//              ],
//            ),
//            Container(
//              height: 40,
//              width: double.infinity,
//              child: RaisedButton(
//                child: Text(NavigationButtonText),
//                onPressed: () {
//                  SetNumber++; //何セット目か
//                  for (int i = 0; i < 49; i++) {
//                    ServerList[i] = !ServerList[i]; //サーブ権は１セット目と２セット目で逆
//                    ACounter[i] = false;
//                    BCounter[i] = false;
//                  }
//                  APoint = 0;
//                  BPoint = 0;
//                  count = 0;
//                  side = !side;
//                  deuce = false;
//                  ATeamWin = false;
//                  BTeamWin = false;
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => PointCounting()));
//                },
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
