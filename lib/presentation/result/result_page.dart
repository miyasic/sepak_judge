import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting_page.dart';
import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/presentation/result/result_model.dart';

class ResultPage extends StatelessWidget {
  final ResultMatch = Match();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      home: ChangeNotifierProvider<ResultModel>(
        create: (_) => ResultModel(), //ResultModelを作成
        child: Scaffold(
          appBar: AppBar(
            title: Text('result'),
          ),
          body: Consumer<ResultModel>(
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
                          if (ResultMatch.ATeamWin)
                            Text(ResultMatch.ATeamName,
                                style: TextStyle(fontSize: 40)),
                          if (!ResultMatch.ATeamWin)
                            Text(ResultMatch.ATeamName,
                                style: TextStyle(
                                    fontSize: 40, color: Colors.black38)),
                          if (ResultMatch.BTeamWin)
                            Text(ResultMatch.BTeamName,
                                style: TextStyle(fontSize: 40)),
                          if (!ResultMatch.BTeamWin)
                            Text(ResultMatch.BTeamName,
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
                                '${ResultMatch.AScore[i]}',
                                style: Theme.of(context).textTheme.display1,
                              ),
                              Text(
                                "${ResultMatch.BScore[i]}",
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
                        child: Text(ResultMatch.NavigationButtonText),
                        onPressed: () {
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
