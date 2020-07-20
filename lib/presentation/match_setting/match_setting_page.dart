import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting_page.dart';
import 'match_setting_model.dart';
import 'package:sepakjudge/domain/file_manager.dart';

class MatchSettingPage extends StatelessWidget {
  MatchSettingPage(this.filemanager);
  final FileManager filemanager;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      home: ChangeNotifierProvider<MatchSettingModel>(
        create: (_) => MatchSettingModel(filemanager), //MatchSettingModelを作成
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
                              controller: model.filemanager.matchNameController,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'ATeam',
                              ),
                              onChanged: (Text) {
                                model.filemanager.teamName[0] =
                                    model.filemanager.aTeamNameController.text;
                              },
                              controller: model.filemanager.aTeamNameController,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'BTeam',
                              ),
                              onChanged: (Text) {
                                model.filemanager.teamName[1] =
                                    model.filemanager.bTeamNameController.text;
                              },
                              controller: model.filemanager.bTeamNameController,
                            ),
                            Column(
                              children: <Widget>[
                                TextField(
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'ServiceTeam',
                                  ),
                                  controller:
                                      model.filemanager.serviceController,
                                ),
                                PopupMenuButton<String>(
                                  initialValue: '',
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onSelected: (String value) {
                                    if (value == Null) {
                                      print('a');
                                    }
                                    model.filemanager.serviceController.text =
                                        value;
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return model.filemanager.teamName
                                        .map<PopupMenuItem<String>>(
                                            (String value) {
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
                                model.match.setServer();
                                model.setFileContents();
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
