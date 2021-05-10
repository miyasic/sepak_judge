import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sepakjudge/domain/assosiations.dart';
import 'package:sepakjudge/domain/competition.dart';
import 'package:sepakjudge/domain/player.dart';
import 'package:sepakjudge/domain/regu.dart';
import 'package:sepakjudge/repository/associaiton_repository.dart';
import 'package:sepakjudge/repository/player_repository.dart';
import 'package:sepakjudge/repository/teams_repository.dart';
import 'package:sepakjudge/utils/dialog_utils.dart';

import '../../constants.dart';

class EntryCompetitionModel extends ChangeNotifier {
  EntryCompetitionModel(this.competition);
  final Competition competition;
  List<DateTime> competitionDates;

  final _associationRepository = AssociationsRepository.instance;
  final _teamsRepository = TeamsRepository.instance;
  final _playerRepository = PlayersRepository.instance;

  Player _currentUser;
  Association association;
  List<Player> members;
  final reguNameController = TextEditingController();
  List<List> playerNameControllerList = [
    [TextEditingController(text: '1人目'), TextEditingController(), FocusNode()],
    [TextEditingController(text: '2人目'), TextEditingController(), FocusNode()],
    [TextEditingController(text: '3人目'), TextEditingController(), FocusNode()],
  ];
  final captainController = TextEditingController();
  int captainPickerIndex = 0;
  ReguFireStore regu = ReguFireStore();

  Future init(context) async {
    try {
      //大会情報
      competitionDates = getCompetitionDates();
      association =
          await _associationRepository.fetch(competition.associationId);
      //レグ情報
      _currentUser = await _playerRepository.fetch();
      _initRegu();
      setMyNameTextField();
    } catch (e) {
      DialogUtils.showSimpleDialog(text: e.toString(), context: context);
    }
    notifyListeners();
  }

  //大会情報の整理
  List<DateTime> getCompetitionDates() {
    List<DateTime> dates = [];
    for (int i = 0; i < competition.competitionDays; i++) {
      dates.add(competition.competitionDate.add(Duration(days: i)));
    }
    return dates;
  }

  //regu情報の整理
  void _initRegu() {
    regu.setMemberIds(_currentUser.playerId);
    print(regu.memberIds);
    print(regu.memberNumbers);
  }

  void setMyNameTextField() {
    playerNameControllerList[0][0].text = _currentUser.name;
  }

  void setMember(Player member, int index, BuildContext context) {
    //選択されているメンバーの場合はダイアログを出すだけ
    if (regu.memberIds.contains(member.playerId)) {
      DialogUtils.showSimpleDialog(
          text: '${member.name}はすでにメンバーに入っています。 ', context: context);
    } else {
      playerNameControllerList[index][0].text = member.name;
      regu.memberIds[index] = member.playerId;
    }
    notifyListeners();
  }

  void addPlayer() {
    int x = this.playerNameControllerList.length + 1;
    if (x < 7) {
      this.playerNameControllerList.add([
        TextEditingController(text: '$x人目'),
        TextEditingController(),
        FocusNode()
      ]);
      this.regu.addMember();
    }
    onChangedReguInfo('');
    notifyListeners();
    print(regu.memberNumbers);
    print(regu.memberIds);
  }

  void deletePlayer() {
    if (this.playerNameControllerList.length > 3) {
      this.playerNameControllerList.removeLast();
      this.regu.deleteMember();
    }
    onChangedReguInfo('');
    notifyListeners();
    print(regu.memberNumbers);
    print(regu.memberIds);
  }

  void onChangedReguInfo(String text) {
    for (int i = 0; i < playerNameControllerList.length; i++) {
//      regu.members[i].name = playerNameControllerList[i][0].text;
      try {
        regu.memberNumbers[i] = int.parse(playerNameControllerList[i][1].text);
      } catch (e) {
        print(e);
      }
      ;
      regu.name = reguNameController.text;
      regu.numMember = playerNameControllerList.length;
    }
  }

  void showCaptainPicker(
    context,
  ) {
    final _pickerItems =
        playerNameControllerList.map((player) => Text(player[0].text)).toList();
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: themeSecondBackColor,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              scrollController:
                  FixedExtentScrollController(initialItem: captainPickerIndex),
              itemExtent: 32,
              children: _pickerItems,
              onSelectedItemChanged: (int index) {
                captainPickerIndex = index;
                captainController.text =
                    playerNameControllerList[index][0].text;
                regu.captainId = regu.memberIds[index];
              },
            ),
          ),
        );
      },
    );
  }

  entry(BuildContext context) {
    if (_checkEntryInfo(context)) {
      _teamsRepository.entryCompetitions(
          _currentUser.teamId, competition.competitionId, regu);
    }
  }

  _checkEntryInfo(BuildContext context) {
    //アップロードする前のチェック
    //全てのテキストフィールドが埋まっているか
    //背番号・選手にダブりがないか
    //キャプテンがレグに存在しているか(キャプテンを選んだ後にその選手が変更されていないか
    if (regu.name.isEmpty) {
      DialogUtils.showSimpleDialog(text: 'レグ名を入力してください', context: context);
      return false;
    } else if (regu.memberIds.contains(null)) {
      DialogUtils.showSimpleDialog(text: '選手名の項目は全て埋めてください', context: context);
      return false;
    } else if (regu.memberNumbers.contains(null)) {
      DialogUtils.showSimpleDialog(text: '背番号のの項目は全て埋めてください', context: context);
      return false;
    } else if (regu.captainId == null || regu.captainId.isEmpty) {
      DialogUtils.showSimpleDialog(text: 'キャプテンが登録されていません', context: context);
      return false;
    } else if (regu.memberNumbers.length !=
        regu.memberNumbers.toSet().toList().length) {
      DialogUtils.showSimpleDialog(
          text: '背番号は重複しないようにしてください', context: context);
      return false;
    } else if (regu.memberIds.length !=
        regu.memberIds.toSet().toList().length) {
      DialogUtils.showSimpleDialog(text: '選手が重複しています', context: context);
      return false;
    } else if (!regu.memberIds.contains(regu.captainId)) {
      DialogUtils.showSimpleDialog(
          text: 'キャプテンが登録されていない選手です', context: context);
      return false;
    }
    return true;
  }
}
