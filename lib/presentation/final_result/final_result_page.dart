import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/domain/file_manager.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/presentation/main/main.dart';

import 'final_result_model.dart';

class FinalResultPage extends StatelessWidget {
  FinalResultPage(this.match);
  Match match;
  final fileManager = FileManager();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FinalResultModel>(
      create: (_) => FinalResultModel(match), //mainmodelを作成
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
                        Flexible(
                          child: Text(model.match.aTeamName,
                              style: TextStyle(
                                fontSize: 40,
                              )),
                        ),
                        Flexible(
                          child: Text(model.match.bTeamName,
                              style: TextStyle(
                                fontSize: 40,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      for (int i = 0; i < 3; i++) //set毎の結果を表示する
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '${match.aScore[i]}',
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
                  if (model.match.winner == 1)
                    Flexible(
                      child: Text(
                        '${model.match.aTeamName} WIN',
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
                  if (model.match.winner == -1)
                    Flexible(
                      child: Text(
                        '${model.match.bTeamName} WIN',
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          child: Text('final Result'),
                          onPressed: () async {
                            await fileManager.makeOutputAndShare(match);
                            model.resetMatch();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                                (route) => false);
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
    );
  }
}
