import 'package:flutter/material.dart';
import 'package:sepakjudge/presentation/match_setting/match_setting_page.dart';
import 'package:sepakjudge/presentation/result/result_page.dart';
import 'package:sepakjudge/presentation/final_result/final_result_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: double.infinity,
                    height: 48,
                    child: RaisedButton(
                      child: Text(
                        'Open File',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Match Setting',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MatchSettingPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
