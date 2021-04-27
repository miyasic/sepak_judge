import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';
import 'team_select_model.dart';

class TeamSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeamSelectModel>(
      create: (_) => TeamSelectModel()..init(), //TeamSelectModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('TeamSelectPage'),
        ),
        body: Consumer<TeamSelectModel>(
          builder: (context, model, child) {
            if (model.teams == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: model.teams.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        model.teams[index].name), //inputFileNamesは初期値に空白が入っている。
                    onTap: () async {
                      await DialogUtils.showOKCancelAlertDialog(
                          context: context,
                          text: '${model.teams[index].name}に所属申請を送信してもよろしいですか？',
                          okAction: () async {
                            try {
                              await model.applyTeams(model.teams[index].teamId);
                              print('送信しました。');
                              Navigator.pop(context, true);
                            } catch (e) {
                              DialogUtils.showSimpleDialog(
                                  text: e.toString(), context: context);
                            }
                          },
                          cancelAction: () {
                            print('送信しませんでした。');
                          });
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
