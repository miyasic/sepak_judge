import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/constants.dart';
import 'package:sepakjudge/presentation/match_details_setting/match_details_setting_page.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting_page.dart';
import 'match_setting_model.dart';
import 'package:sepakjudge/domain/file_manager.dart';

class MatchSettingPage extends StatelessWidget {
  MatchSettingPage(this.fileManager, {this.inputFileData});
  final FileManager fileManager;
  final List<String> inputFileData;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MatchSettingModel>(
      create: (_) =>
          MatchSettingModel(fileManager, inputFileData: inputFileData)
            ..init(), //MatchSettingModelを作成
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
                child: SingleChildScrollView(
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
                                model.teamName[0] =
                                    model.aTeamNameController.text;
                              },
                              controller: model.aTeamNameController,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'BTeam',
                              ),
                              onChanged: (Text) {
                                model.teamName[1] =
                                    model.bTeamNameController.text;
                              },
                              controller: model.bTeamNameController,
                            ),
                            Column(
                              children: <Widget>[
                                TextField(
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'ServiceTeam',
                                  ),
                                  controller: model.serviceController,
                                ),
                                PopupMenuButton<String>(
                                  initialValue: '',
                                  color: themeBackGroundColor,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onSelected: (String value) {
                                    model.serviceController.text = value;
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return model.teamName
                                        .map<PopupMenuItem<String>>(
                                            (String value) {
                                      return new PopupMenuItem(
                                          child: new Text(
                                            value,
                                          ),
                                          value: value);
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 160),
                          child: Container(
                            width: 200,
                            child: Column(
                              children: [
                                Container(
                                  child: RaisedButton(
                                    child: Text(kTextDetailSetting),
                                    onPressed: () {
                                      model.setMatchSetting();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MatchDetailSettingPage(
                                                      model.match)));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: RaisedButton(
                                    child: Text(kTextGameStart),
                                    onPressed: () {
                                      model.setMatchSetting();

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PointCountingPage(
                                                      model.match)));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
