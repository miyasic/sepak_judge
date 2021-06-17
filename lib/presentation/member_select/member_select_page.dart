import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'member_select_model.dart';

class MemberSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemberSelectModel>(
      create: (_) => MemberSelectModel()..init(context), //MemberSelectModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('レグメイトの選択'),
        ),
        body: Consumer<MemberSelectModel>(
          builder: (context, model, child) {
            if (model.members == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.all(3),
                  itemCount: model.members.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        tileColor: themeSecondBackColor,
                        title: Text(
                          model.members[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
//                        leading: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Text(
//                              '${model.members[index].name}',
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
////                          Text('${model.competitions[index].division}'),
//                          ],
//                        ), //in
//                        trailing: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            Text('エントリー締め切り',
//                                style: TextStyle(fontWeight: FontWeight.bold)),
////                          Text(model.members[index].entryDeadline
////                              .toYearMonthDateDOWString()),
//                          ],
//                        ),
                        onTap: () async {
                          //todo:選択したプレイヤーを返す。
                          Navigator.pop(context, model.members[index]);
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
