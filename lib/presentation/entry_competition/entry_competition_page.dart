import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/constants.dart';
import 'package:sepakjudge/domain/competition.dart';
import 'entry_competition_model.dart';
import 'package:sepakjudge/date_extensions.dart';

class EntryCompetitionPage extends StatelessWidget {
  EntryCompetitionPage(this.competition);
  final Competition competition;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EntryCompetitionModel>(
      create: (_) => EntryCompetitionModel(competition)
        ..init(context), //EntryCompetitionModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('大会申し込み'),
        ),
        body: Consumer<EntryCompetitionModel>(
          builder: (context, model, child) {
            if (model.association == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              child: Column(
                children: [
                  Card(
                    elevation: 2,
                    child: Container(
                      color: themeSecondBackColor.withOpacity(0.5),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              competition.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('主催'),
                                    Text('会場'),
                                    Text('Division'),
                                    Text('申込締め切り'),
                                    Text('開催日'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.association.name,
                                      style: TextStyle(
//                                      fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      competition.stadium,
                                      style: TextStyle(
//                                      fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      competition.division,
                                      style: TextStyle(
//                                      fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      competition.entryDeadline
                                          .toYearMonthDateDOWString(),
                                      style: TextStyle(
//                                      fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      getCompetitionDatesText(
                                        model.competitionDates,
                                      ),
                                      style: TextStyle(
//                                      fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text("レグメンバー"),
                  ),
                  //チーム名用のテキストフィールド
//                  TextField(
//                    style: TextStyle(
//                        fontSize: 16, fontWeight: FontWeight.bold),
//                    decoration: InputDecoration(
//                      border: OutlineInputBorder(),
//                      labelText: 'チーム名',
//                    ),
//                    controller: model.teamNameController,
//                    onChanged: model.onChangedTeamInfo,
//                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '選手名と背番号',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  getTextFieldList(model.playerNameControllerList,
                      model.onChangedReguInfo, context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton.icon(
                        onPressed: () {
                          model.addPlayer();
                        },
                        icon: Icon(Icons.exposure_plus_1),
                        label: Text(kTextAddMember),
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          model.deletePlayer();
                        },
                        icon: Icon(Icons.exposure_minus_1),
                        label: Text(kTextMinusMember),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'キャプテン',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'キャプテン',
                      ),
                      controller: model.captainController,
                      onChanged: model.onChangedReguInfo,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        model.showCaptainPicker(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                      child: Text(kTextRegister),
                      onPressed: () {
//                        model.register(context);
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String getCompetitionDatesText(List<DateTime> competitionDates) {
    if (competitionDates.length == 1) {
      return competitionDates[0].toYearMonthDateDOWString();
    } else {
      String text = competitionDates[0].toYearMonthDateDOWString();
      for (int i = 1; i < competitionDates.length; i++) {
        text = text + ',' + competitionDates[i].toMonthDateDOWString();
      }
      return text;
    }
  }

  Widget getTextFieldList(
      List<List> playerList, onChanged, BuildContext context) {
    return Column(
      children: playerList
          .map(
            (player) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '選手名',
                      ),
                      controller: player[0],
                      onChanged: onChanged,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '背番号',
                      ),
                      controller: player[1],
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
