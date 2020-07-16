import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/domain/file_manager.dart';
import 'open_file_model.dart';

class OpenFilePage extends StatelessWidget {
  final filemanager = FileManager();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      home: ChangeNotifierProvider<OpenFileModel>(
        create: (_) => OpenFileModel(filemanager), //MatchSettingModelを作成
        child: Scaffold(
          appBar: AppBar(
            title: Text('OpenFile'),
          ),
          body: Consumer<OpenFileModel>(
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 500,
                        child: Container(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              color: Colors.white,
                              child: ListView.builder(
                                itemCount:
                                    model.filemanager.inputFileNames.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                        '${model.filemanager.inputFileNames[index]}'),
                                    onTap: () {
                                      //todo:画面遷移・ファイルからデータ取得
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: RaisedButton(
                                color: Colors.blue,
                                child: Text(
                                  'ファイルを表示する',
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                                onPressed: () {
                                  //todo:inputFilesNameを格納する。
                                  model.fileset();
                                },
                              ),
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
