import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/constants.dart';
import 'package:sepakjudge/presentation/sign_up/signup_page.dart';
import 'package:sepakjudge/presentation/team_select/team_select_page.dart';
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
                ? withLogin(model, context)
                : withoutLogin(model, context);
          },
        ),
      ),
    );
  }

  Widget withLogin(MyModel model, context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'あなたのプロフィール',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '名前',
                    ),
                    controller: model.nameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'メールアドレス',
                    ),
                    controller: model.emailController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '性別',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('男性'),
                      Radio(
                        value: true,
                        groupValue: model.isMale,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text('女性'),
                      Radio(
                        value: false,
                        groupValue: model.isMale,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(child: Text('プロフィール変更'), onPressed: () async {}),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '所属チームが登録されていません',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
              child: Text('所属チームを選ぶ'),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TeamSelectPage()));
              }),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(child: Text('大会申し込み'), onPressed: () async {}),
              RaisedButton(child: Text('　大会一覧　'), onPressed: () async {}),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
              child: Text('　サインアウト　'),
              color: themeSecondBackColor,
              onPressed: () async {
                await model.logout();
              }),
        ],
      ),
    );
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
