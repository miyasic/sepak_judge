import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/sign_up/signup_page.dart';

import '../../main.dart';
import 'my_model.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel(), //TempModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('MyPage'),
        ),
        body: Consumer<MyModel>(
          builder: (context, model, child) {
            return isLogin ? withLogin(model) : withoutLogin(model, context);
          },
        ),
      ),
    );
  }

  Widget withLogin(MyModel model) {
    return Center(child: Text('ログイン済みです。'));
  }

  Widget withoutLogin(MyModel model, context) {
    return Center(
        child: Column(
      children: [
        Text('ログインして下さい'),
        Container(
          child: RaisedButton(
            child: Text('SignUp'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
            },
          ),
        ),
      ],
    ));
  }
}
