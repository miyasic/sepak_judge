//非同期処理用ライブラリ
import 'dart:async';
//ファイル出力用ライブラリ
import 'dart:io';

//アプリがファイルを保存可能な場所を取得するライブラリ
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:sepakjudge/domain/match.dart';

class FileManager {
  var documentDirectory; //documentDirectoryを格納する。
  var outputFileName; //保存するファイル名
  var outText = ''; //ファイルに出力する文字列
  List inputFileNames = ['']; //読み込むファイル名の配列

  final matchNameController = TextEditingController(text: 'MatchName');
  final aTeamNameController = TextEditingController(text: 'ATeam');
  final bTeamNameController = TextEditingController(text: 'BTeam');
  final serviceController = TextEditingController();
  var teamName = ['ATeam', 'BTeam'];

  //テキストフィールドの初期値を変更する。OpenFileModelで呼び出し
  void changeInitialText(String matchName, String aTeamName, String bTeamName) {
    matchNameController.text = matchName;
    aTeamNameController.text = aTeamName;
    bTeamNameController.text = bTeamName;
    teamName = [aTeamName, bTeamName];
  }

  //ファイル名からファイルの中身を取り出す。OpenFileModelで呼び出し
  Future<String> getFileData(String fileName) async {
    var text = await _load(await _getInPutFilePath(fileName));
    return text;
  }

  //ファイル名から入力するテキストファイルのパスを取得する
  Future<String> _getInPutFilePath(String fileName) async {
    documentDirectory = await getApplicationDocumentsDirectory();
    final filePath = await documentDirectory.path + '/Inbox/' + fileName;
    return filePath;
  }

  //テキストファイルの読み込み
  Future<String> _load(filePath) async {
    final file = await File(filePath);
    return file.readAsString();
  }

  //受け取ったファイル名をinputFileNamesに格納する。Mainで呼び出し
  Future<void> setInputFileName() async {
    documentDirectory = await getApplicationDocumentsDirectory();
    final systemTempDir = await Directory(documentDirectory.path + '/Inbox');
    if (inputFileNames.length == 1) {
      await for (var value in systemTempDir.list()) {
        String inputFileTemp = value.path.split('/').last as String;
        inputFileNames.add(inputFileTemp.toString());
      }
    }
  }

  void makeOutputAndShare(Match match) async {
    _setFileName(match);
    _setFileContents(match);
    await _outPutFiles();
    await loadButton();
    await _share();
  }

  //outputFilenameをセットする。
  void _setFileName(Match match) {
    outputFileName = match.fileContents[0] + '.csv';
  }

  //ファイルに出力する文字列をセットする。
  void _setFileContents(Match match) {
    outText = match.fileContents[0] +
        ',' +
        match.fileContents[1] +
        ',' +
        match.fileContents[2];
    for (int i = 0; i < 3; i++) {
      outText = outText + "," + "${match.aScore[i]} vs ${match.bScore[i]}";
    }
  }

//ファイルの出力処理
  void _outPutFiles() async {
    final file = await _getOutputFile();
    await file.writeAsString(outText);
  }

  //出力するテキストファイルを取得する
  Future<File> _getOutputFile() async {
    documentDirectory = await getApplicationDocumentsDirectory();
    return File(documentDirectory.path + '/' + outputFileName);
  }

  //出力したファイルを共有する
  void _share() async {
    await FlutterShare.shareFile(
      title: 'Example share',
      filePath: documentDirectory.path + '/' + outputFileName,
    );
  }

  Future loadButton() async {
    print(await _load(documentDirectory.path + '/' + outputFileName));
  }
}
