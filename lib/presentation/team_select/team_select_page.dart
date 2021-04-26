import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'team_select_model.dart';

class TeamSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeamSelectModel>(
      create: (_) => TeamSelectModel(), //TeamSelectModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('TeamSelectPage'),
        ),
        body: Consumer<TeamSelectModel>(
          builder: (context, model, child) {
            return Container();
          },
        ),
      ),
    );
  }
}
