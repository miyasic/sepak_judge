import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting_page.dart';
import 'match_setting_model.dart';

class MatchSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      home: ChangeNotifierProvider<MatchSettingModel>(
        create: (_) => MatchSettingModel(), //MatchSettingModelを作成
        child: Scaffold(
          appBar: AppBar(
            title: Text('MatchSetting'),
          ),
          body: Consumer<MatchSettingModel>(
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 400,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'MatchName',
                              ),
                              controller: model.matchNameController,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'ATeam',
                              ),
                              onChanged: (Text) {
                                model.TeamName[0] =
                                    model.ATeamNameController.text;
                              },
                              controller: model.ATeamNameController,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'BTeam',
                              ),
                              onChanged: (Text) {
                                model.TeamName[1] =
                                    model.BTeamNameController.text;
                              },
                              controller: model.BTeamNameController,
                            ),
                            Column(
                              children: <Widget>[
                                TextField(
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'ServiceTeam',
                                  ),
                                  controller: model.ServiceController,
                                ),
                                PopupMenuButton<String>(
                                  initialValue: '',
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onSelected: (String value) {
                                    if (value == Null) {
                                      print('a');
                                    }
                                    model.ServiceController.text = value;
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return model.TeamName.map<
                                        PopupMenuItem<String>>((String value) {
                                      return new PopupMenuItem(
                                          child: new Text(value), value: value);
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 160),
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            child: RaisedButton(
                              child: Text('GameStart'),
                              onPressed: () {
                                model.setTeamName();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PointCountingPage(model.match)));
                                model.setFirstServe();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
