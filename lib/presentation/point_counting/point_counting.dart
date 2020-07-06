import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/count_funcs.dart';
import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
import 'package:sepakjudge/presentation/final_result/final_result.dart';
import 'point_counting_model.dart';

class PointCountingPage extends StatelessWidget {
//  Widget counting() {
//    if (side) {
//      return Container(
//        height: double.infinity,
//        width: double.infinity,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            if (server)
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Text(ATeamName,
//                      style: TextStyle(
//                        fontSize: 50,
//                      )),
//                  Text(BTeamName,
//                      style: TextStyle(
//                        fontSize: 40,
//                        color: Colors.black12,
//                      )),
//                ],
//              ),
//            if (!server)
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Text(ATeamName,
//                      style: TextStyle(fontSize: 40, color: Colors.black12)),
//                  Text(BTeamName,
//                      style: TextStyle(
//                        fontSize: 50,
//                        color: Colors.black,
//                      )),
//                ],
//              ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Text(
//                  '$APoint',
//                  style: Theme.of(context).textTheme.display1,
//                ),
//                Text(
//                  "$BPoint",
//                  style: Theme.of(context).textTheme.display1,
//                ),
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                RaisedButton(
//                  child: Text(ATeamName),
//                  onPressed: () {
//                    ifPushACountPoint();
//                  },
//                ),
//                RaisedButton(
//                  child: Text(BTeamName),
//                  onPressed: () {
//                    ifPushBCountPoint();
//                  },
//                ),
//              ],
//            ),
//            //以下コートチェンジ
//
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                RaisedButton(
//                  child: Text('return'),
//                  onPressed: () {
//                    ifPushReturnButton();
//                  },
//                ),
//                RaisedButton(
//                  child: Text('SideChange'),
//                  onPressed: () {
//                    setState(() {
//                      side = !side;
//                      print(side);
//                    });
//                  },
//                ),
//              ],
//            )
//          ],
//        ),
//      );
//    }
//    if (!side) {
//      return Container(
//        height: double.infinity,
//        width: double.infinity,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            if (server)
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Text(BTeamName,
//                      style: TextStyle(
//                        fontSize: 40,
//                        color: Colors.black12,
//                      )),
//                  Text(ATeamName,
//                      style: TextStyle(
//                        fontSize: 50,
//                      )),
//                ],
//              ),
//            if (!server)
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Text(BTeamName,
//                      style: TextStyle(
//                        fontSize: 50,
//                        color: Colors.black,
//                      )),
//                  Text(ATeamName,
//                      style: TextStyle(fontSize: 40, color: Colors.black12)),
//                ],
//              ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Text(
//                  "$BPoint",
//                  style: Theme.of(context).textTheme.display1,
//                ),
//                Text(
//                  '$APoint',
//                  style: Theme.of(context).textTheme.display1,
//                ),
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                RaisedButton(
//                  child: Text(BTeamName),
//                  onPressed: () {
//                    ifPushBCountPoint();
//                  },
//                ),
//                RaisedButton(
//                  child: Text(ATeamName),
//                  onPressed: () {
//                    ifPushACountPoint();
//                  },
//                ),
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                RaisedButton(
//                  child: Text('return'),
//                  onPressed: () {
//                    ifPushReturnButton();
//                  },
//                ),
//                RaisedButton(
//                  child: Text('SideChange'),
//                  onPressed: () {
//                    setState(() {
//                      side = !side;
//                      print(side);
//                    });
//                  },
//                ),
//              ],
//            )
//          ],
//        ),
//      );
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      home: ChangeNotifierProvider<PointCountingModel>(
        create: (_) => PointCountingModel(), //mainmodelを作成
        child: Scaffold(
          appBar: AppBar(
            title: Text('1st'),
          ),
//          body: counting(),
        ),
      ),
    );
  }
}
//        if (SetNumber == 2) {
//      return Scaffold(
//        appBar: AppBar(
//          title: Text('2nd'),
//        ),
//        body: counting(),
//      );
//    }
//    if (SetNumber == 3) {
//      return Scaffold(
//        appBar: AppBar(
//          title: Text('3rd'),
//        ),
//        body: counting(),
//      );
//    }
