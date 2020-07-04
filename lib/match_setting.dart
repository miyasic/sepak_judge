import 'package:flutter/material.dart';
import 'package:sepakjudge/point_counting.dart';
import 'package:sepakjudge/file_funcs.dart';


final MatchNameController = TextEditingController();
final ATeamNameController = TextEditingController();
final BTeamNameController = TextEditingController();
final ServiceController = TextEditingController();
var OutText = '';
List FileContentsList = ['','','',''];
var items = ['ATeam','BTeam'];
var firstServe;

class MatchSetting extends StatefulWidget{
  @override
  State createState(){
    //画面遷移後に読み込まれるviewdidload的な感じ
    MatchNameController.text ='A1';
    ATeamNameController.text ='RAPORA A';
    BTeamNameController.text ='TAKTAK B';
    ServiceController.text ='RAPORA A';
    items[0] = ATeamNameController.text;
    items[1] = BTeamNameController.text;
    return _MatchSettingState();
  }
}

class _MatchSettingState extends State<MatchSetting>{
  //Stateclass
//  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('MatchSetting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
//          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
//        color: Colors.red,
                height: 400,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'MatchName',
                      ),
                      controller: MatchNameController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ATeam',
                      ),
                      onChanged: (Text){
                        items[0] = ATeamNameController.text;
                      },
                      controller: ATeamNameController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'BTeam',
                      ),
                      onChanged: (Text){
                        items[1] = BTeamNameController.text;
                      },
                      controller: BTeamNameController,
                    ),
                    Column(
                      children: <Widget>[
                        TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'ServiceTeam',
                          ),
                          controller: ServiceController,
                        ),
                        PopupMenuButton<String>(
                          initialValue: '',
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            if(value == Null){
                              print('a');
                            }
                            ServiceController.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return items.map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0, 160),
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    child: RaisedButton(
                      child: Text('GameStart'),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PointCounting()));
//                        Navigator.pop(context);
                        FileContentsList[0] = MatchNameController.text;
                        FileContentsList[1] = ATeamNameController.text;
                        FileContentsList[2] = BTeamNameController.text;
                        FileContentsList[3] = ServiceController.text;
                        if(FileContentsList[3] == FileContentsList[2]){
                          firstServe = false;
                        }else{
                          firstServe = true;
                        }
//                        OutText = FileContentsList[0] + '\n' + FileContentsList[1] + '\n' + FileContentsList[2];
//                        fileName = FileContentsList[0] + ".txt";
                        OutText = FileContentsList[0] + ',' + FileContentsList[1] + ',' + FileContentsList[2];
                        fileName = FileContentsList[0] + ".csv";
                        print('$FileContentsList');
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}