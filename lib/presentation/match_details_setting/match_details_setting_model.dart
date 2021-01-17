import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/domain/team.dart';

class MatchDetailsSettingModel extends ChangeNotifier {
  MatchDetailsSettingModel({this.match, this.index});
  bool isCompleted = false;
  //NavigationBottomBar用
  int index;
  Match match;

  void setIndex(int index) {
    this.index = index;
    notifyListeners();
  }

  //TeamSettingPage用
  Team team = Team(members: []);
  final teamNameController = TextEditingController();
  final captainController = TextEditingController();
  List<List> playerNameControllerList = [
    [TextEditingController(text: '1人目'), TextEditingController()],
    [TextEditingController(text: '2人目'), TextEditingController()],
    [TextEditingController(text: '3人目'), TextEditingController()],
    [TextEditingController(text: '4人目'), TextEditingController()],
    [TextEditingController(text: '5人目'), TextEditingController()],
    [TextEditingController(text: '6人目'), TextEditingController()],
  ];

  //RefereeSettingPage用
  final chiefRefereeController = TextEditingController();
  final assistantRefereeController = TextEditingController();
  final courtNameController = TextEditingController();
  final matchNameController = TextEditingController();
  final serviceTeamController = TextEditingController();
  List<String> teamName = ['ATeam', 'BTeam'];

  void init() {
    print(match.aTeam.members);
    if (match.aTeam.members.length != 0 && match.bTeam.members.length != 0) {
      if (index == 0) {
        teamNameController.text = match.aTeamName;
        for (int i = 0; i < 6; i++) {
          playerNameControllerList[i][0].text = match.aTeam.members[i].name;
          playerNameControllerList[i][1].text = match.aTeam.members[i].number;
          //右辺に選手の名前がnullの場合の文字列を入れる。
          if (playerNameControllerList[i][0].text == '') {
            for (int j = i; j < 6; j++) {
              playerNameControllerList.removeLast();
            }
            break;
          }
          team.members.add(Player());
        }
      } else if (index == 2) {
        teamNameController.text = match.bTeamName;
        for (int i = 0; i < 6; i++) {
          playerNameControllerList[i][0].text = match.bTeam.members[i].name;
          playerNameControllerList[i][1].text = match.bTeam.members[i].number;
          //右辺に選手の名前がnullの場合の文字列を入れる。
          if (playerNameControllerList[i][0].text == '') {
            for (int j = i; j < 6; j++) {
              playerNameControllerList.removeLast();
            }
            break;
          }
          team.members.add(Player());
        }
      } else if (index == 1) {
        chiefRefereeController.text = match.chiefReferee;
        assistantRefereeController.text = match.assistantReferee;
        courtNameController.text = match.courtName;
        matchNameController.text = match.matchName;
        serviceTeamController.text =
            match.server ? match.aTeamName : match.bTeamName;
        teamName[0] = match.aTeamName;
        teamName[1] = match.bTeamName;
        print(match.assistantReferee);
      }
//      onChanged('');
    } else {
      //ファイルを読み込んでいない場合
      for (int i = 0; i < 3; i++) {
        this.team.members.add(Player());
      }
    }
  }

  void addPlayer() {
    int x = this.playerNameControllerList.length + 1;
    if (x < 7) {
      this
          .playerNameControllerList
          .add([TextEditingController(text: '$x人目'), TextEditingController()]);
      this.team.members.add(Player());
    }
    onChangedTeamInfo('');
    notifyListeners();
  }

  void deletePlayer() {
    if (this.playerNameControllerList.length > 3) {
      this.playerNameControllerList.removeLast();
      this.team.members.removeLast();
    }
    onChangedTeamInfo('');
    notifyListeners();
  }

  void onChangedTeamInfo(String text) {
    for (int i = 0; i < playerNameControllerList.length; i++) {
      team.members[i].name = playerNameControllerList[i][0].text;
      team.members[i].number = playerNameControllerList[i][1].text;
    }
    team.name = teamNameController.text;
    team.captain = captainController.text;
    if (index == 0) {
      match.aTeamName = team.name;
    } else if (index == 2) {
      match.bTeamName = team.name;
    }
  }

  void onChangedRefereeInfo(String text) {
    match.chiefReferee = chiefRefereeController.text;
  }

  void regist() {
    if (this.index == 0) {
      onChangedTeamInfo('');
      team.isInputCompleted = true;
      match.aTeam = team;
    } else if (this.index == 2) {
      onChangedTeamInfo('');
      team.isInputCompleted = true;
      match.bTeam = team;
    } else if (this.index == 1) {
      onChangedRefereeInfo('');
      match.chiefReferee = chiefRefereeController.text;
      match.assistantReferee = assistantRefereeController.text;
    }
    isCompleted = true;
    notifyListeners();
  }
}
