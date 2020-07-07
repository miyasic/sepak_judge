import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting_page.dart';
import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/presentation/main/main.dart';

import 'final_result_model.dart';

class FinalResultPage extends StatelessWidget {
  final FinalResultMatch = Match();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      home: ChangeNotifierProvider<FinalResultModel>(
        create: (_) => FinalResultModel(), //mainmodelを作成
        child: Scaffold(
          appBar: AppBar(
            title: Text('result'),
          ),
          body: Consumer<FinalResultModel>(
            builder: (context, model, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(FinalResultMatch.ATeamName,
                              style: TextStyle(
                                fontSize: 50,
                              )),
                          Text(FinalResultMatch.BTeamName,
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
                                '${FinalResultMatch.AScore[i]}',
                                style: Theme.of(context).textTheme.display1,
                              ),
                              Text(
                                "${FinalResultMatch.BScore[i]}",
                                style: Theme.of(context).textTheme.display1,
                              ),
                            ],
                          ),
                      ],
                    ),
                    if (FinalResultMatch.Winner == 1)
                      Text(
                        '$FinalResultMatch.ATeamName WIN',
                        style: TextStyle(fontSize: 50),
                      ),
                    if (FinalResultMatch.Winner == -1)
                      Text(
                        '$FinalResultMatch.BTeamName WIN',
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
//                                OutText =
//                                    OutText + "," + "${FinalResultMatch.AScore[i]} vs ${FinalResultMatch.BScore[i]}";
                              }
//                              outButton();
                            },
                          ),
                          RaisedButton(
                            child: Text('fainl Result'),
                            onPressed: () {
//                              share();

                              //変数の初期化
                              FinalResultMatch.ATeamName = 'TeamA';
                              FinalResultMatch.BTeamName = 'TeamB';
                              FinalResultMatch.SetNumber = 1; //何セット目か
                              FinalResultMatch.server = true;
                              for (int i = 0; i < 3; i++) {
                                FinalResultMatch.AScore[i] = 0;
                                FinalResultMatch.BScore[i] = 0;
                                FinalResultMatch.SetCount[i] = 0;
                              }
                              for (int i = 0; i < 49; i++) {
                                FinalResultMatch.ServerList[i] =
                                    !FinalResultMatch
                                        .ServerList[i]; //サーブ権は１セット目と２セット目で逆
                                FinalResultMatch.ACounter[i] = false;
                                FinalResultMatch.BCounter[i] = false;
                              }
                              FinalResultMatch.APoint = 0;
                              FinalResultMatch.BPoint = 0;
                              FinalResultMatch.count = 0;
                              FinalResultMatch.side = true;
                              FinalResultMatch.deuce = false;
                              FinalResultMatch.ATeamWin = false;
                              FinalResultMatch.BTeamWin = false;
                              FinalResultMatch.Winner = 0;
                              FinalResultMatch.GameSet = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
