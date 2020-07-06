import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting.dart';
import 'package:sepakjudge/count_funcs.dart';
import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
import 'package:sepakjudge/domain/match.dart';

class ResultPage extends StatelessWidget {
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
                          if (model.ATeamWin)
                            Text(model.ATeamName,
                                style: TextStyle(fontSize: 40)),
                          if (!model.ATeamWin)
                            Text(model.ATeamName,
                                style: TextStyle(
                                    fontSize: 40, color: Colors.black38)),
                          if (model.BTeamWin)
                            Text(model.BTeamName,
                                style: TextStyle(fontSize: 40)),
                          if (!model.BTeamWin)
                            Text(model.BTeamName,
                                style: TextStyle(
                                    fontSize: 40, color: Colors.black38)),
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
                    Container(
                      height: 40,
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text(model.NavigationButtonText),
                        onPressed: () {
                          model.SetNumber++; //何セット目か
                          for (int i = 0; i < 49; i++) {
                            model.ServerList[i] =
                                !model.ServerList[i]; //サーブ権は１セット目と２セット目で逆
                            model.ACounter[i] = false;
                            model.BCounter[i] = false;
                          }
                          model.APoint = 0;
                          model.BPoint = 0;
                          model.count = 0;
                          model.side = !model.side;
                          model.deuce = false;
                          model.ATeamWin = false;
                          model.BTeamWin = false;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PointCountingPage()));
                        },
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
