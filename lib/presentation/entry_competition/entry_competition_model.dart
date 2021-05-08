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

  String test = 'aiueo';
  final _associationRepository = AssociationsRepository.instance;
  final _reguRepository = TeamsRepository.instance;
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
//      members = await _reguRepository.fetchMembers(_currentUser.teamId);
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
//      regu.members[i].number = playerNameControllerList[i][1].text;
    }
    regu.name = reguNameController.text;
//    regu.captain = captainController.text;
  }

  void showCaptainPicker(
    context,
  ) {
//    final _pickerItems = regu.members.map((item) => Text(item.name)).toList();

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
//              children: _pickerItems,
              onSelectedItemChanged: (int index) {
                captainPickerIndex = index;
//                captainController.text = regu.members[captainPickerIndex].name;
              },
            ),
          ),
        );
      },
    );
  }
}
