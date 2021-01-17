import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/presentation/match_details_setting/match_details_setting_model.dart';

class RefereeDetailsPage extends StatelessWidget {
  RefereeDetailsPage(this.match, this.index);
  Match match;
  int index;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MatchDetailsSettingModel>(
      create: (_) =>
          MatchDetailsSettingModel(match: match, index: index)..init(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MatchDetailsSettingModel>(
            builder: (context, model, child) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '試合番号',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  //チーム名用のテキストフィールド
                  TextField(
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '試合番号',
                    ),
                    controller: model.matchNameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'コート名',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  //チーム名用のテキストフィールド
                  TextField(
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'コート名',
                    ),
                    controller: model.courtNameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '主審',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  //チーム名用のテキストフィールド
                  TextField(
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'チーム名',
                    ),
                    controller: model.chiefRefereeController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '副審',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  //チーム名用のテキストフィールド
                  TextField(
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'チーム名',
                    ),
                    controller: model.assistantRefereeController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'サーブ権',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  //チーム名用のテキストフィールド
                  Column(
                    children: <Widget>[
                      TextField(
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        autofocus: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ServiceTeam',
                        ),
                        controller: model.serviceTeamController,
                      ),
                      PopupMenuButton<String>(
                        initialValue: '',
                        icon: const Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                          model.serviceTeamController.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          List<String> teamName = [
                            model.match.aTeamName,
                            model.match.bTeamName
                          ];
                          return teamName
                              .map<PopupMenuItem<String>>((String value) {
                            return new PopupMenuItem(
                                child: new Text(value), value: value);
                          }).toList();
                        },
                      ),
                    ],
                  ),
                  RaisedButton(
                      child: Text('登録する'),
                      onPressed: () {
                        model.regist();
                      }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
