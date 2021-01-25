import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/match.dart';
import 'package:sepakjudge/domain/team.dart';
import 'package:sepakjudge/presentation/point_counting/point_counting_page.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

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
    if (index == 0) {
      teamNameController.text = match.aTeamName;
      captainController.text = match.aTeam.captain;
      for (int i = 0; i < 6; i++) {
        playerNameControllerList[i][0].text = match.aTeam.members[i].name;
        playerNameControllerList[i][1].text = match.aTeam.members[i].number;
        //右辺に選手の名前がnullの場合の文字列を入れる。
        if (playerNameControllerList[i][0].text == '') {
          for (int j = i; j < 6; j++) {
            playerNameControllerList.removeLast();
            match.aTeam.members.removeLast();
          }
          break;
        }
        team.members = match.aTeam.members;
      }
    } else if (index == 2) {
      teamNameController.text = match.bTeamName;
      captainController.text = match.bTeam.captain;
      for (int i = 0; i < 6; i++) {
        playerNameControllerList[i][0].text = match.bTeam.members[i].name;
        playerNameControllerList[i][1].text = match.bTeam.members[i].number;
        //右辺に選手の名前がnullの場合の文字列を入れる。
        if (playerNameControllerList[i][0].text == '') {
          for (int j = i; j < 6; j++) {
            playerNameControllerList.removeLast();
            match.bTeam.members.removeLast();
          }
          break;
        }
        team.members = match.bTeam.members;
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

  void onChangedRefereeInfo(String text, context) {
    match.matchName = matchNameController.text;
    match.courtName = courtNameController.text;
    match.chiefReferee = chiefRefereeController.text;
    match.assistantReferee = assistantRefereeController.text;
    if (match.aTeam.name == serviceTeamController.text) {
      match.server = true;
    } else if (match.bTeam.name == serviceTeamController.text) {
      match.server = false;
    } else {
      DialogUtils.showAlertDialog(
          text: 'サーブ権に該当するチームが存在しません。チーム登録した名前と同じ名前のチームをサーブ権欄に入力してください。',
          context: context,
          completion: () {});
    }
  }

  void reInputTeamInfo() {
    isCompleted = false;
    if (this.index == 0) {
      match.aTeam.isInputCompleted = false;
    } else if (this.index == 2) {
      match.bTeam.isInputCompleted = false;
    }
    notifyListeners();
  }

  void register(context) {
    print(this.index);
    if (this.index == 0) {
      print('a');
      if (checkIsEnoughTeamInfo()) {
        onChangedTeamInfo('');
        team.isInputCompleted = true;
        match.aTeam = team;
        isCompleted = true;
      } else {
        DialogUtils.showAlertDialog(
            text: 'チーム情報が不十分です。全ての項目を入力してください。',
            context: context,
            completion: () {});
      }
    } else if (this.index == 2) {
      if (checkIsEnoughTeamInfo()) {
        onChangedTeamInfo('');
        team.isInputCompleted = true;
        match.bTeam = team;
        isCompleted = true;
      } else {
        DialogUtils.showAlertDialog(
            text: 'チーム情報が不十分です。全ての項目を入力してください。',
            context: context,
            completion: () {});
      }
    } else if (this.index == 1) {
      onChangedRefereeInfo('', context);
      match.chiefReferee = chiefRefereeController.text;
      match.assistantReferee = assistantRefereeController.text;
    }
    notifyListeners();
  }

  ///TeamDetailsPage用
  bool checkIsEnoughTeamInfo() {
    ///選手情報の確認
    bool isEnoughMember = true;
    for (int i = 0; i < playerNameControllerList.length; i++) {
      if (playerNameControllerList[i][0].text == '' ||
          playerNameControllerList[i][1].text == '') {
        isEnoughMember = false;
        break;
      }
    }

    ///チーム情報の確認
    bool ans = isEnoughMember &&
        teamNameController.text != '' &&
        captainController.text != '';
    return ans;
  }

  ///RefereeDetailsPage用
  bool checkIsEnoughRefereeInfo() {
    bool ans = matchNameController.text != '' &&
        courtNameController.text != '' &&
        chiefRefereeController.text != '' &&
        assistantRefereeController.text != '' &&
        serviceTeamController.text != '';
    return ans;
  }

  void startGame(context) {
    if (!match.aTeam.isInputCompleted) {
      DialogUtils.showAlertDialog(
          text: 'ATeamの入力が完了していません。\nATeamの入力ページからチーム情報を登録してください。',
          context: context,
          completion: () {});
    } else if (!match.bTeam.isInputCompleted) {
      DialogUtils.showAlertDialog(
          text: 'BTeamの入力が完了していません。\nBTeamの入力ページからチーム情報を登録してください。',
          context: context,
          completion: () {});
    } else if (!checkIsEnoughRefereeInfo()) {
      DialogUtils.showAlertDialog(
          text: '試合情報が不十分です。\n全ての項目を入力してください。',
          context: context,
          completion: () {});
    } else {
      match.fileInput = true;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PointCountingPage(match)));
    }
  }
}
