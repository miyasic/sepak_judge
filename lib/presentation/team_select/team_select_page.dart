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
                  void onTapWhenSelectTeam() async {
                    await DialogUtils.showOKCancelAlertDialog(
                        context: context,
                        text: '${model.teams[index].name}に所属申請を送信してもよろしいですか？',
                        okAction: () async {
                          try {
                            await model.applyTeams(model.teams[index].teamId,
                                model.teams[index].name);
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
                  }

                  void onTapWhenChangeTeam() async {
                    if (model.playerTeamName == model.teams[index].name) {
                      try {
                        DialogUtils.showSimpleDialog(
                            text: '${model.playerTeamName}は現在所属している団体です。',
                            context: context);
                      } catch (e, s) {
                        print(s);
                      }
                    } else {
                      await DialogUtils.showOKCancelAlertDialog(
                        text:
                            '${model.playerTeamName}から${model.teams[index].name}に移籍します。\n両団体に移籍申請を送信してもよろしいですか？',
                        context: context,
                        okAction: () async {
                          try {
                            await model.changeTeams(model.teams[index].teamId,
                                model.teams[index].name);
                            print('送信しました。');
                            Navigator.pop(context, true);
                          } catch (e) {
                            DialogUtils.showSimpleDialog(
                                text: e.toString(), context: context);
                          }
                        },
                        cancelAction: () {
                          print('送信しませんでした。');
                        },
                      );
                    }
                  }

                  return ListTile(
                    title: Text(
                        model.teams[index].name), //inputFileNamesは初期値に空白が入っている。
                    onTap: model.player.teamId == "no_team"
                        ? onTapWhenSelectTeam
                        : onTapWhenChangeTeam,
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
