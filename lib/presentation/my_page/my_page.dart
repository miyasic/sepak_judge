import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/sign_up/signup_page.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

import '../../main.dart';
import 'my_model.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel()..init(context), //TempModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('MyPage'),
        ),
        body: Consumer<MyModel>(
          builder: (context, model, child) {
            return isLogin && model.player != null
                ? withLogin(model)
                : withoutLogin(model, context);
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
        Text(model.player.name),
      ],
    ));
  }

  Widget withoutLogin(MyModel model, context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 80,
                          width: 80,
                          child: Icon(
                            Icons.account_circle_sharp,
                            size: 60,
                          )),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'メールアドレス',
                        ),
                        controller: model.emailController,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'パスワード',
                        ),
                        controller: model.passController,
                      ),
                      RaisedButton(
                        child: Text('SignIn'),
                        onPressed: () async {
                          model.startLoading();
                          await model.signin(context);
                          model.endLoading();
                        },
                      ),
                      Container(
                        child: RaisedButton(
                          child: Text('SignUp'),
                          onPressed: () async {
                            bool isDone = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                            if (isDone) {
                              await DialogUtils.showAlertDialog(
                                  text: 'アカウントを作成しました',
                                  context: context,
                                  completion: () {
                                    model.init(context);
                                  });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
        model.isLoading
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black12,
                child: Center(child: CircularProgressIndicator()),
              )
            : Container()
      ],
    );
  }
}
