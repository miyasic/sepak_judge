//非同期処理用ライブラリ
import 'dart:async';
//ファイル出力用ライブラリ
import 'dart:io';

//アプリがファイルを保存可能な場所を取得するライブラリ
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:sepakjudge/domain/match.dart';

class FileManager {
  var documentDirectory; //documentDirectoryを格納する。
  var outputFileName; //保存するファイル名
  var outText = ''; //ファイルに出力する文字列
  List inputFileNames = ['']; //読み込むファイル名の配列

  //出力するテキストファイルを取得する
  Future<File> getOutputFile() async {
    documentDirectory = await getApplicationDocumentsDirectory();
    return File(documentDirectory.path + '/' + outputFileName);
  }

  //受け取ったファイル名をinputFileNamesに格納する。
  Future<void> setInputFileName() async {
    documentDirectory = await getApplicationDocumentsDirectory();

    var systemTempDir = await Directory(documentDirectory.path + '/Inbox');
    // List directory contents, recursing into sub-directories,
    // but not following symbolic links.
    await systemTempDir
        .list(recursive: true, followLinks: false)
        .listen((FileSystemEntity entity) async {
      String inputFileTemp = await entity.path.split('/').last as String;
      await inputFileNames.add(inputFileTemp.toString());
    });
  }

  //テキストファイルの読み込み
  Future<String> load() async {
    final file = await getOutputFile();
    return file.readAsString();
  }

  //outputFilenameをセットする。
  void setFileName(Match match) {
    outputFileName = match.fileContents[0] + '.txt';
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
  void outPutFiles() async {
    final file = await getOutputFile();
    await file.writeAsString(outText);
  }

  //出力したファイルを共有する
  void share() async {
    await FlutterShare.shareFile(
      title: 'Example share',
      filePath: documentDirectory.path + '/' + outputFileName,
    );
  }
}
