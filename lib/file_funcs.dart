////非同期処理用ライブラリ
//import 'dart:async';
////ファイル出力用ライブラリ
//import 'dart:io';
//
////アプリがファイルを保存可能な場所を取得するライブラリ
//import 'package:path_provider/path_provider.dart';
//import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
//import 'package:flutter_share/flutter_share.dart';
//import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
//
//var directory;
//var fileName = FileContentsList[0] + ".txt"; //保存するファイルの名前
//
////テキストファイルを保存するパスを取得する
//Future<File> getFilePath() async {
//  directory = await getTemporaryDirectory();
//  return File(directory.path + '/' + fileName);
//}
//
////テキストファイルの読み込み
//Future<String> load() async {
//  final file = await getFilePath();
//  return file.readAsString();
//}
//
////ファイルの出力処理
//void outButton() async {
//  getFilePath().then((File file) {
////    file.writeAsString(_textController.text);
//    file.writeAsString(OutText);
//  });
//}
//
//void loadButton() async {
//  load().then((String value) {
//    var out = value;
//    print(out);
//  });
//}
//
//void share() async {
//  FlutterShare.shareFile(
//    title: 'Example share',
//    text: 'Example share text',
//    filePath: directory.path + '/' + fileName,
//  );
//}
//////ファイルの読み込みと変数への格納処理
////void loadButton() async {
////  setState(() {
////    load().then((String value) {
////      setState(() {
////        _out = value;
////      });
////    });
////  });
////}
