import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/constants.dart';
import 'package:sepakjudge/domain/competition.dart';
import 'package:sepakjudge/domain/player.dart';
import 'package:sepakjudge/presentation/member_select/member_select_page.dart';
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      competition.stadium,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      competition.division,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      competition.entryDeadline
                                          .toYearMonthDateDOWString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      getCompetitionDatesText(
                                        model.competitionDates,
                                      ),
                                      style: TextStyle(
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
                  //チーム名用のテキストフィールド
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'レグ名',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'レグ名',
                              ),
                              controller: model.reguNameController,
                              onChanged: model.onChangedReguInfo,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '選手名と背番号',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          getTextFieldList(
                              model.playerNameControllerList, model, context),
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
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
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
                    ),
                  ),
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

  Widget getTextFieldList(List<List> playerList, EntryCompetitionModel model,
      BuildContext context) {
    List<Widget> textFieldList = [];

    for (int i = 0; i < playerList.length; i++) {
      textFieldList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 60,
              child: TextField(
                focusNode: AlwaysDisabledFocusNode(),
                onTap: () async {
                  final member = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MemberSelectPage()));
                  model.setMember(member, i, context);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '選手名',
                ),
                controller: playerList[i][0],
                onChanged: model.onChangedReguInfo,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 105,
              child: KeyboardActions(
                config: _buildConfig(context, playerList),
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '背番号',
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    focusNode: playerList[i][2],
                    controller: playerList[i][1],
                    onChanged: model.onChangedReguInfo,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: textFieldList.toList(),
    );
  }

  /////　やってみる

  KeyboardActionsConfig _buildConfig(
      BuildContext context, List<List> playerList) {
    final keyboardActionsList = playerList
        .map(
          (player) =>
              KeyboardActionsItem(focusNode: player[2], toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Done',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              );
            }
          ]),
        )
        .toList();
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: keyboardActionsList);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
