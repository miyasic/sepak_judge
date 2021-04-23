import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/domain/match.dart';

import 'temp_model.dart';

class TempPage extends StatelessWidget {
  String text = 'a';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TempModel>(
      create: (_) => TempModel(), //TempModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('result'),
        ),
        body: Consumer<TempModel>(
          builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        text = await model.fetchData();
                        model.notifyListeners();
                      },
                      child: Text('push')),
                  Text(text),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
