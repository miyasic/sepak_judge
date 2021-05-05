import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/constants.dart';
import 'entry_competition_model.dart';
import 'package:sepakjudge/date_extensions.dart';

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
            return Container(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.all(3),
                  itemCount:
                      model.competitions.length, //inputFileNamesは初期値に空白が入っている。
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        tileColor: themeSecondBackColor,
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${model.competitions[index].name}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('${model.competitions[index].division}'),
                          ],
                        ), //in
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('エントリー締め切り',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(model.competitions[index].entryDeadline
                                .toYearMonthDateDOWString()),
                          ],
                        ),
                        shape: Border(), // putFileNamesは初期値に空白が入っている。
                        onTap: () async {
                          //todo:画面遷移・ファイルからデータ取得
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
