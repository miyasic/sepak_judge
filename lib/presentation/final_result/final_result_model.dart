import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';

class FinalResultModel extends ChangeNotifier {
  FinalResultModel(this.match);
  Match match;
}
