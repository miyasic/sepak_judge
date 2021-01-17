import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sepakjudge/domain/file_manager.dart';

class OpenFileModel extends ChangeNotifier {
  OpenFileModel(this.filemanager);
  final FileManager filemanager;
  List<String> inputFileData;

  Future setMatchSettings(fileName) async {
    final text = await filemanager.getFileData(fileName);
    inputFileData = await text.split(',');
  }
}
