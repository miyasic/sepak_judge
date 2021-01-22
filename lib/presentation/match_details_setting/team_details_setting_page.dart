import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/presentation/match_details_setting/match_details_setting_model.dart';

class TeamDetailsSettingPage extends StatelessWidget {
  TeamDetailsSettingPage(this.match, this.index);
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
          return model.isCompleted
              ? Container(
                  color: Colors.grey,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${model.team.name}の\n入力が完了しました!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      RaisedButton(
                          child: Text('入力情報を変更する'),
                          onPressed: () {
                            model.reInputTeamInfo();
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '必要な情報の入力が終わったら\nRefereeタブから試合を開始してください',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                )
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'チーム名',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        //チーム名用のテキストフィールド
                        TextField(
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'チーム名',
                          ),
                          controller: model.teamNameController,
                          onChanged: model.onChangedTeamInfo,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '選手名と背番号',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        getTextFieldList(model.playerNameControllerList,
                            model.onChangedTeamInfo, context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton.icon(
                              onPressed: () {
                                model.addPlayer();
                              },
                              icon: Icon(Icons.exposure_plus_1),
                              label: Text('選手枠の追加'),
                            ),
                            RaisedButton.icon(
                              onPressed: () {
                                model.deletePlayer();
                              },
                              icon: Icon(Icons.exposure_minus_1),
                              label: Text('選手枠の削除'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'キャプテン',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: TextField(
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'キャプテン',
                                ),
                                controller: model.captainController,
                                onChanged: model.onChangedTeamInfo,
                              ),
                            ),
                            PopupMenuButton<String>(
                              initialValue: '',
                              icon: const Icon(Icons.arrow_drop_down),
                              onSelected: (String value) {
                                model.captainController.text = value;
                                model.onChangedTeamInfo(value);
                              },
                              itemBuilder: (BuildContext context) {
                                return model.team.members
                                    .map<PopupMenuItem<String>>((player) {
                                  return new PopupMenuItem(
                                      child: new Text(player.name),
                                      value: player.name);
                                }).toList();
                              },
                            ),
                            RaisedButton(
                                child: Text('確認する'),
                                onPressed: () {
                                  model.checkIsEnoughTeamInfo();
                                }),
                            RaisedButton(
                                child: Text('登録する'),
                                onPressed: () {
                                  model.register(context);
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }

  Widget getTextFieldList(
      List<List> playerList, onChanged, BuildContext context) {
    return Column(
      children: playerList
          .map(
            (player) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '選手名',
                      ),
                      controller: player[0],
                      onChanged: onChanged,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '背番号',
                      ),
                      controller: player[1],
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
