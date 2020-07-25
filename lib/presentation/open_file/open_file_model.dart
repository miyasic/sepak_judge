import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sepakjudge/domain/file_manager.dart';

class OpenFileModel extends ChangeNotifier {
  OpenFileModel(this.filemanager);
  final FileManager filemanager;

  Future<void> setMatchSettings(fileName) async {
    final text = await filemanager.getFileData(fileName);
    List settings = await text.split(',');
    await filemanager.changeInitialText(settings[0], settings[1], settings[2]);
  }
}
