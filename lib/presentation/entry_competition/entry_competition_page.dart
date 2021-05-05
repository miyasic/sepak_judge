import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'entry_competition_model.dart';

class EntryCompetitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EntryCompetitionModel>(
      create: (_) =>
          EntryCompetitionModel()..init(context), //EntryCompetitionModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('大会申し込み'),
        ),
        body: Consumer<EntryCompetitionModel>(
          builder: (context, model, child) {
            return Container();
          },
        ),
      ),
    );
  }
}
