import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/constants.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting_page.dart';
import 'package:sepakjudge/domain/match.dart';
import 'result_model.dart';

class ResultPage extends StatelessWidget {
  ResultPage(this.match);
  final Match match;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResultModel>(
      create: (_) => ResultModel(match), //ResultModelを作成
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
                        if (model.match.aTeamWin)
                          Flexible(
                            child: Text(model.match.aTeamName,
                                style: TextStyle(fontSize: 40)),
                          ),
                        if (!model.match.aTeamWin)
                          Flexible(
                            child: Text(model.match.aTeamName,
                                style: TextStyle(
                                    fontSize: 40, color: Colors.black38)),
                          ),
                        if (model.match.bTeamWin)
                          Flexible(
                            child: Text(model.match.bTeamName,
                                style: TextStyle(fontSize: 40)),
                          ),
                        if (!model.match.bTeamWin)
                          Flexible(
                            child: Text(model.match.bTeamName,
                                style: TextStyle(
                                    fontSize: 40, color: Colors.black38)),
                          ),
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
                              '${model.match.aScore[i]}',
                              style: Theme.of(context).textTheme.display1,
                            ),
                            Text(
                              "${model.match.bScore[i]}",
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ],
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      child: RaisedButton(
                        child: Text(kTextNextSet),
                        onPressed: () {
                          model.setNextSet();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PointCountingPage(model.match)),
                              (route) => false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
