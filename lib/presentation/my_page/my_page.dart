import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/sign_up/signup_page.dart';

import '../../main.dart';
import 'my_model.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel()..init(), //TempModelを作成
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
    return Center(
        child: Column(
      children: [
        RaisedButton(onPressed: () async {
          await model.logout();
        }),
        Text('ログイン済みです。'),
      ],
    ));
  }

  Widget withoutLogin(MyModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: double.infinity,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'メールアドレス',
                      ),
                      controller: model.emailController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'パスワード',
                      ),
                      controller: model.passController,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('SignIn'),
                onPressed: () {
                  model.signin(context);
                },
              ),
            ],
          ))),
    );
//    return Center(
//        child: Column(
//      children: [
//        Text('ログインして下さい'),
//        Container(
//          child: RaisedButton(
//            child: Text('SignUp'),
//            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => SignupPage()));
//            },
//          ),
//        ),
//      ],
//    ));
  }
}
