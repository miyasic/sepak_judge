import 'package:flutter/material.dart';
import 'package:sepakjudge/constants.dart';
import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
import 'package:sepakjudge/presentation/open_file/open_file_page.dart';
import 'package:sepakjudge/domain/file_manager.dart';
import 'package:sepakjudge/presentation/temp/temp_page.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      theme: ThemeData(
          primaryColor: themeMainColor,
          scaffoldBackgroundColor: themeBackGroundColor,
          canvasColor: themeSecondColor,
          buttonTheme: ButtonThemeData(
            buttonColor: themeSecondColor,
            textTheme: ButtonTextTheme.primary,
          )),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final fileManager = FileManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kServiceName),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                        color: themeMainColor,
                        child: Text(
                          'TempPage',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        onPressed: () async {
                          //todo:OpenFilePageに遷移
                          try {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TempPage()),
                            );
                          } catch (e) {
                            DialogUtils.showAlertDialog(
                                text: e, context: context);
                          } finally {}
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 48,
                      child: RaisedButton(
                        color: themeMainColor,
                        child: Text(
                          'Open File',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        onPressed: () async {
                          //todo:OpenFilePageに遷移
                          try {
                            await fileManager.setInputFileName();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OpenFilePage(fileManager)),
                            );
                          } catch (e) {
                            DialogUtils.showAlertDialog(
                                text: e, context: context);
                          } finally {}
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: RaisedButton(
                        color: themeMainColor,
                        child: Text(
                          'Match Setting',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        onPressed: () {
                          //todo:MatchSettingPageに遷移
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MatchSettingPage()),
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
