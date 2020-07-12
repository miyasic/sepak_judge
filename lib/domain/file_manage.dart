//非同期処理用ライブラリ
import 'dart:async';
//ファイル出力用ライブラリ
import 'dart:io';

//アプリがファイルを保存可能な場所を取得するライブラリ
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:sepakjudge/domain/match.dart';

class FileManage {
  final match = Match();
  var directory;
  var fileName; //保存するファイルの名前
  var outText = ''; //ファイルに出力する文字列

//テキストファイルを保存するパスを取得する
  Future<File> getFilePath() async {
    directory = await getTemporaryDirectory();
    return File(directory.path + '/' + fileName);
  }

//テキストファイルの読み込み
  Future<String> load() async {
    final file = await getFilePath();
    return file.readAsString();
  }

  //filenameをセットする。
  void setFileName(Match match) {
    fileName = match.fileContents[0] + '.txt';
  }

  void setOutText(Match match) {
    int size = match.fileContents.length;
    for (int i = 0; i < size; i++) {
      outText = match.fileContents[i] + '\n';
    }
  }

  //ファイルに出力する文字列をセットする。
  void setFileContents(Match match) {
    outText = match.fileContents[0] +
        '\n' +
        match.fileContents[1] +
        '\n' +
        match.fileContents[2];
    for (int i = 0; i < 3; i++) {
      outText = outText + "\n" + "${match.aScore[i]} vs ${match.bScore[i]}";
    }
  }

//ファイルの出力処理
  void outButton() async {
    getFilePath().then((File file) {
      file.writeAsString(outText);
    });
  }

  void loadButton() async {
    load().then((String value) {
      var out = value;
      print(out);
    });
  }

  void share() async {
    FlutterShare.shareFile(
      title: 'Example share',
      filePath: directory.path + '/' + fileName,
    );
  }
}
