//非同期処理用ライブラリ
import 'dart:async';
//ファイル出力用ライブラリ
import 'dart:io';

//アプリがファイルを保存可能な場所を取得するライブラリ
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:sepakjudge/constants.dart';
import 'package:sepakjudge/domain/match.dart';

bool isAndroid = Platform.isAndroid;

class FileManager {
  var documentDirectory; //documentDirectoryを格納する。
  var outputFileName; //保存するファイル名
  List inputFileNames; //読み込むファイル名の配列

  //ファイル名からファイルの中身を取り出す。OpenFileModelで呼び出し
  Future<String> getFileData(String fileName) async {
    var text = await _load(await _getInPutFilePath(fileName));
    print(text);
    return text;
  }

  //ファイル名から入力するテキストファイルのパスを取得する
  Future<String> _getInPutFilePath(String fileName) async {
    documentDirectory = await getApplicationDocumentsDirectory();
    String filePath;
    if (isAndroid) {
      filePath = await documentDirectory.path + '/' + fileName;
    } else {
      filePath = await documentDirectory.path + '/Inbox/' + fileName;
    }
    print(filePath);
    return filePath;
  }

  //テキストファイルの読み込み
  Future<String> _load(filePath) async {
    final file = await File(filePath);
    return file.readAsString();
  }

  //受け取ったファイル名をinputFileNamesに格納する。Mainで呼び出し
  Future<void> setInputFileName() async {
    inputFileNames = [''];
    documentDirectory = await getApplicationDocumentsDirectory();
    if (isAndroid) {
      ///以下Android
      final systemTempDir = await Directory(documentDirectory.path); //android
      if (await systemTempDir.exists()) {
        await for (var value in systemTempDir.list()) {
          String inputFileTemp = value.path.split('/').last as String;
          if (inputFileTemp.split('.').last.endsWith('csv')) {
            inputFileNames.add(inputFileTemp.toString());
          }
        }
      } else {
        throw '読み込めるファイルがありません。csv形式のファイルを$kServiceNameに読み込んでください。';
      }
    } else {
      ///以下iOS
      final systemTempDir =
          await Directory(documentDirectory.path + '/Inbox'); //iOS
      print(systemTempDir.path);
      //systemTempDirの中にファイルが存在するかどうか
      if (await systemTempDir.exists()) {
        await for (var value in systemTempDir.list()) {
          String inputFileTemp = value.path.split('/').last as String;
          inputFileNames.add(inputFileTemp.toString());
        }
      } else {
        throw '読み込めるファイルがありません。csv形式のファイルを$kServiceNameに読み込んでください。';
      }
    }
  }

  void makeOutputAndShare(Match match) async {
    _setFileName(match.matchName);
    await _outPutFiles(_getFileContents(match));
    await loadButton();
    await _share();
  }

  //outputFilenameをセットする。
  void _setFileName(String matchName) {
    outputFileName = matchName + '.csv';
  }

  //ファイルに出力する文字列をセットする。
  String _getFileContents(Match match) {
    return match.getOutPutText();
  }

//ファイルの出力処理
  void _outPutFiles(outputText) async {
    final file = await _getOutputFile();
    await file.writeAsString(outputText);
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
