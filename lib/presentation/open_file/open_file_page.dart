import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/domain/file_manager.dart';
import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
import 'open_file_model.dart';

class OpenFilePage extends StatelessWidget {
  OpenFilePage(this.filemanager);
  final FileManager filemanager;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OpenFileModel>(
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
                child: ListView.builder(
                  itemCount: model.filemanager.inputFileNames.length -
                      1, //inputFileNamesは初期値に空白が入っている。
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          '${model.filemanager.inputFileNames[index + 1]}'), //inputFileNamesは初期値に空白が入っている。
                      onTap: () async {
                        //todo:画面遷移・ファイルからデータ取得
                        await model.setMatchSettings(
                            model.filemanager.inputFileNames[index + 1]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MatchSettingPage(filemanager,
                                inputFileData: model.inputFileData),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
