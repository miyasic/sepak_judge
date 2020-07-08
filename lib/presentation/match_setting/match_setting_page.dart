import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting_page.dart';
import 'package:sepakjudge/file_funcs.dart';
import 'match_setting_model.dart';
import 'package:sepakjudge/domain/match.dart';

class MatchSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      home: ChangeNotifierProvider<MatchSettingModel>(
        create: (_) => MatchSettingModel(), //mainmodelを作成
        child: Scaffold(
          appBar: AppBar(
            title: Text('MatchSetting'),
          ),
          body: Consumer<MatchSettingModel>(
            builder: (context, model, child) {
              return Container(
                width: double.infinity,
                height: double.infinity,
//          color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
//        color: Colors.red,
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
                            controller: model.MatchNameController,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ATeam',
                            ),
                            onChanged: (Text) {
                              model.items[0] = model.ATeamNameController.text;
                            },
                            controller: model.ATeamNameController,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'BTeam',
                            ),
                            onChanged: (Text) {
                              model.items[1] = model.BTeamNameController.text;
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
                                  return model.items.map<PopupMenuItem<String>>(
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
                              model.match.ATeamName =
                                  model.ATeamNameController.text;
                              model.match.BTeamName =
                                  model.BTeamNameController.text;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PointCountingPage(model.match)));
                              model.FileContentsList[0] =
                                  model.MatchNameController.text;
                              model.FileContentsList[1] =
                                  model.ATeamNameController.text;
                              model.FileContentsList[2] =
                                  model.BTeamNameController.text;
                              model.FileContentsList[3] =
                                  model.ServiceController.text;
                              if (model.FileContentsList[3] ==
                                  model.FileContentsList[2]) {
                                model.firstServe = false;
                              } else {
                                model.firstServe = true;
                              }
//                        OutText = FileContentsList[0] + '\n' + FileContentsList[1] + '\n' + FileContentsList[2];
//                        fileName = FileContentsList[0] + ".txt";
                              model.OutText = model.FileContentsList[0] +
                                  ',' +
                                  model.FileContentsList[1] +
                                  ',' +
                                  model.FileContentsList[2];
//                              fileName = model.FileContentsList[0] + ".csv";
                              print('$model.FileContentsList');
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
