import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting.dart';
import 'package:sepakjudge/count_funcs.dart';
import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/presentation/main/main.dart';

class FinalResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      home: ChangeNotifierProvider<Match>(
        create: (_) => Match(), //mainmodelを作成
        child: Scaffold(
          appBar: AppBar(
            title: Text('result'),
          ),
          body: Consumer<Match>(
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
                          Text(model.ATeamName,
                              style: TextStyle(
                                fontSize: 50,
                              )),
                          Text(model.BTeamName,
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
                                '${model.AScore[i]}',
                                style: Theme.of(context).textTheme.display1,
                              ),
                              Text(
                                "${model.BScore[i]}",
                                style: Theme.of(context).textTheme.display1,
                              ),
                            ],
                          ),
                      ],
                    ),
                    if (model.Winner == 1)
                      Text(
                        '$model.ATeamName WIN',
                        style: TextStyle(fontSize: 50),
                      ),
                    if (model.Winner == -1)
                      Text(
                        '$model.BTeamName WIN',
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
//                                    OutText + "," + "${model.AScore[i]} vs ${model.BScore[i]}";
                              }
//                              outButton();
                            },
                          ),
                          RaisedButton(
                            child: Text('fainl Result'),
                            onPressed: () {
//                              share();

                              //変数の初期化
                              model.ATeamName = 'TeamA';
                              model.BTeamName = 'TeamB';
                              model.SetNumber = 1; //何セット目か
                              model.server = true;
                              for (int i = 0; i < 3; i++) {
                                model.AScore[i] = 0;
                                model.BScore[i] = 0;
                                model.SetCount[i] = 0;
                              }
                              for (int i = 0; i < 49; i++) {
                                model.ServerList[i] =
                                    !model.ServerList[i]; //サーブ権は１セット目と２セット目で逆
                                model.ACounter[i] = false;
                                model.BCounter[i] = false;
                              }
                              model.APoint = 0;
                              model.BPoint = 0;
                              model.count = 0;
                              model.side = true;
                              model.deuce = false;
                              model.ATeamWin = false;
                              model.BTeamWin = false;
                              model.Winner = 0;
                              model.GameSet = false;
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
