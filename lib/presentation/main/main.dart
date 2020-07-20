import 'package:flutter/material.dart';
import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
import 'package:sepakjudge/presentation/open_file/open_file_page.dart';
import 'package:sepakjudge/domain/file_manager.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final filemanager = FileManager();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sepak Judge'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 48,
                      child: RaisedButton(
                        child: Text(
                          'Open File',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        onPressed: () async {
                          //todo:OpenFilePageに遷移
                          await filemanager.setInputFileName();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OpenFilePage(filemanager)),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Match Setting',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        onPressed: () {
                          //todo:MatchSettingPageに遷移
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MatchSettingPage(filemanager)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
