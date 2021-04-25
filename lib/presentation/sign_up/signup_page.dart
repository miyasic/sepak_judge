import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/presentation/sign_up/signup_model.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignupModel>(
      create: (_) => SignupModel(), //TempModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('SignUp'),
        ),
        body: Consumer<SignupModel>(
          builder: (context, model, child) {
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
                                labelText: '名前',
                              ),
                              controller: model.nameController,
                            ),
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
                            Text(
                              '性別',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('男性'),
                                Radio(
                                  value: true,
                                  groupValue: model.isMale,
                                  onChanged: (value) {
                                    model.changeRadioButton(value);
                                  },
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text('女性'),
                                Radio(
                                  value: false,
                                  groupValue: model.isMale,
                                  onChanged: (value) {
                                    model.changeRadioButton(value);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      RaisedButton(
                        child: Text('SignUp'),
                        onPressed: () {
                          model.SignUp(context, () {
                            print('a');
                          });
                        },
                      ),
                    ],
                  ))),
            );
          },
        ),
      ),
    );
  }
}
