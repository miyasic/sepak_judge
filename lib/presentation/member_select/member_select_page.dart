import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'member_select_model.dart';

class MemberSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemberSelectModel>(
      create: (_) => MemberSelectModel(), //MemberSelectModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('レグメイトの選択'),
        ),
        body: Consumer<MemberSelectModel>(
          builder: (context, model, child) {
            return Container();
          },
        ),
      ),
    );
  }
}
