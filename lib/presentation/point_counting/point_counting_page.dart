import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'point_counting_model.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/presentation/final_result/final_result_page.dart';
import 'package:sepakjudge/presentation/result/result_page.dart';

class PointCountingPage extends StatelessWidget {
  PointCountingPage(this.match);
  final Match match;
  Widget countingWigets() {
    return ChangeNotifierProvider<PointCountingModel>(
      create: (_) => PointCountingModel(match),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        // ignore: missing_return
        child: Consumer<PointCountingModel>(builder: (context, model, child) {
          // ignore: missing_return
          if (model.match.side)
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (model.match.server)
                  Row(
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
                              color: Colors.black12,
                            )),
                      ),
                    ],
                  ),
                if (!model.match.server)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: Text(model.match.aTeamName,
                            style:
                                TextStyle(fontSize: 40, color: Colors.black12)),
                      ),
                      Flexible(
                        child: Text(model.match.bTeamName,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '${model.match.aPoint}',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    Text(
                      "${model.match.bPoint}",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(model.match.aTeamName),
                      onPressed: () {
                        model.ifPushACountPoint();
                        if (model.tieBreakSideChange[0]) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("サイドチェンジ"),
                                content: Text("サイドチェンジしますか？"),
                                actions: <Widget>[
                                  // ボタン領域
                                  FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      model.ifPushSideChangeButton();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        if (model.match.aTeamWin) {
                          if (model.match.gameSet) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FinalResultPage(model.match)));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ResultPage(model.match)));
                          }
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text(model.match.bTeamName),
                      onPressed: () {
                        model.ifPushBCountPoint();
                        if (model.tieBreakSideChange[0]) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("サイドチェンジ"),
                                content: Text("サイドチェンジしますか？"),
                                actions: <Widget>[
                                  // ボタン領域
                                  FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      model.ifPushSideChangeButton();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        if (model.match.bTeamWin) {
                          if (model.match.gameSet) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FinalResultPage(model.match)));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ResultPage(model.match)));
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
          if (!model.match.side)
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (model.match.server)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: Text(model.match.bTeamName,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black12,
                            )),
                      ),
                      Flexible(
                        child: Text(model.match.aTeamName,
                            style: TextStyle(
                              fontSize: 40,
                            )),
                      ),
                    ],
                  ),
                if (!model.match.server)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: Text(model.match.bTeamName,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                            )),
                      ),
                      Flexible(
                        child: Text(model.match.aTeamName,
                            style:
                                TextStyle(fontSize: 40, color: Colors.black12)),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "${model.match.bPoint}",
                      style: Theme.of(context).textTheme.display1,
                    ),
                    Text(
                      '${model.match.aPoint}',
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(model.match.bTeamName),
                      onPressed: () {
                        model.ifPushBCountPoint();
                        if (model.tieBreakSideChange[0]) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("サイドチェンジ"),
                                content: Text("サイドチェンジしますか？"),
                                actions: <Widget>[
                                  // ボタン領域
                                  FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      model.ifPushSideChangeButton();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        if (model.match.bTeamWin) {
                          if (model.match.gameSet) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FinalResultPage(model.match)));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ResultPage(model.match)));
                          }
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text(model.match.aTeamName),
                      onPressed: () {
                        model.ifPushACountPoint();
                        if (model.tieBreakSideChange[0]) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("サイドチェンジ"),
                                content: Text("サイドチェンジしますか？"),
                                actions: <Widget>[
                                  // ボタン領域
                                  FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      model.ifPushSideChangeButton();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        if (model.match.aTeamWin) {
                          if (model.match.gameSet) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FinalResultPage(model.match)));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ResultPage(model.match)));
                          }
                        }
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
        create: (_) => PointCountingModel(match), //mainmodelを作成
        // ignore: missing_return
        child: Consumer<PointCountingModel>(builder: (context, model, child) {
          if (model.match.setNumber == 1) {
            return Scaffold(
              appBar: AppBar(
                title: Text('1st'),
              ),
              body: countingWigets(),
            );
          }
          if (model.match.setNumber == 2) {
            return Scaffold(
              appBar: AppBar(
                title: Text('2nd'),
              ),
              body: countingWigets(),
            );
          }
          if (model.match.setNumber == 3) {
            return Scaffold(
              appBar: AppBar(
                title: Text('3rd'),
              ),
              body: countingWigets(),
            );
          }
        }),
      ),
    );
  }
}
