import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
import 'point_counting_model.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/presentation/final_result/final_result_page.dart';
import 'package:sepakjudge/presentation/result/result_page.dart';

class PointCountingPage extends StatelessWidget {
  Widget counting() {
    return ChangeNotifierProvider<PointCountingModel>(
      create: (_) => PointCountingModel(),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        // ignore: missing_return
        child: Consumer<PointCountingModel>(builder: (context, model, child) {
          // ignore: missing_return
          if (model.PointCountingModelMatch.side)
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (model.PointCountingModelMatch.server)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(model.PointCountingModelMatch.ATeamName,
                          style: TextStyle(
                            fontSize: 50,
                          )),
                      Text(model.PointCountingModelMatch.BTeamName,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black12,
                          )),
                    ],
                  ),
                if (!model.PointCountingModelMatch.server)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(model.PointCountingModelMatch.ATeamName,
                          style:
                              TextStyle(fontSize: 40, color: Colors.black12)),
                      Text(model.PointCountingModelMatch.BTeamName,
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
                      '${model.PointCountingModelMatch.APoint}',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    Text(
                      "${model.PointCountingModelMatch.BPoint}",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(model.PointCountingModelMatch.ATeamName),
                      onPressed: () {
                        model.ifPushACountPoint();
                        if (model.PointCountingModelMatch.ATeamWin) {
                          if (model.PointCountingModelMatch.GameSet) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FinalResultPage()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultPage()));
                          }
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text(model.PointCountingModelMatch.BTeamName),
                      onPressed: () {
                        model.ifPushBCountPoint();
                        if (model.PointCountingModelMatch.BTeamWin) {
                          if (model.PointCountingModelMatch.GameSet) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FinalResultPage()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultPage()));
                          }
                        }
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
                        model.ifPushReturnButton();
                      },
                    ),
                    RaisedButton(
                      child: Text('SideChange'),
                      onPressed: () {
                        model.ifPushSideChangeButton();
                      },
                    ),
                  ],
                )
              ],
            );
          if (!model.PointCountingModelMatch.side)
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (model.PointCountingModelMatch.server)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(model.PointCountingModelMatch.BTeamName,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black12,
                          )),
                      Text(model.PointCountingModelMatch.ATeamName,
                          style: TextStyle(
                            fontSize: 50,
                          )),
                    ],
                  ),
                if (!model.PointCountingModelMatch.server)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(model.PointCountingModelMatch.BTeamName,
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                          )),
                      Text(model.PointCountingModelMatch.ATeamName,
                          style:
                              TextStyle(fontSize: 40, color: Colors.black12)),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "${model.PointCountingModelMatch.BPoint}",
                      style: Theme.of(context).textTheme.display1,
                    ),
                    Text(
                      '${model.PointCountingModelMatch.APoint}',
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(model.PointCountingModelMatch.BTeamName),
                      onPressed: () {
                        model.ifPushBCountPoint();
                        if (model.PointCountingModelMatch.GameSet) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FinalResultPage()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultPage()));
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text(model.PointCountingModelMatch.ATeamName),
                      onPressed: () {
                        model.ifPushACountPoint();
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
                        model.ifPushReturnButton();
                      },
                    ),
                    RaisedButton(
                      child: Text('SideChange'),
                      onPressed: () {
                        model.ifPushSideChangeButton();
                      },
                    ),
                  ],
                )
              ],
            );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      home: ChangeNotifierProvider<PointCountingModel>(
        create: (_) => PointCountingModel(), //mainmodelを作成
        // ignore: missing_return
        child: Consumer<PointCountingModel>(builder: (context, model, child) {
          if (model.PointCountingModelMatch.SetNumber == 1) {
            return Scaffold(
              appBar: AppBar(
                title: Text('1st'),
              ),
              body: counting(),
            );
          }
          if (model.PointCountingModelMatch.SetNumber == 2) {
            return Scaffold(
              appBar: AppBar(
                title: Text('2nd'),
              ),
              body: counting(),
            );
          }
          if (model.PointCountingModelMatch.SetNumber == 3) {
            return Scaffold(
              appBar: AppBar(
                title: Text('3rd'),
              ),
              body: counting(),
            );
          }
        }),
      ),
    );
  }
}
