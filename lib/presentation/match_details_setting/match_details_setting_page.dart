import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepakjudge/constants.dart';
import 'package:sepakjudge/presentation/match_details_setting/match_details_setting_model.dart';
import 'package:sepakjudge/presentation/match_details_setting/referee_details_setting_page.dart';
import 'package:sepakjudge/presentation/match_details_setting/team_details_setting_page.dart';
import 'package:sepakjudge/domain/match.dart';

class MatchDetailSettingPage extends StatelessWidget {
  MatchDetailSettingPage(this.match);
  Match match;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MatchDetailsSettingModel>(
      create: (_) => MatchDetailsSettingModel(
          match: match, index: 0), //MatchSettingModelを作成
      child: Scaffold(
        appBar: AppBar(
          title: Text('MatchDetail'),
        ),
        bottomNavigationBar: Consumer<MatchDetailsSettingModel>(
          builder: (context, model, child) {
            return BottomNavigationBar(
              currentIndex: model.index,
              onTap: (int index) {
                model.setIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: new Image.asset(
                    'assets/iconA.png',
                    height: 40,
                  ),
                  title: new Text(
                    'ATeam',
                    style: TextStyle(color: themeBackGroundColor),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: new Image.asset(
                    'assets/balance.png',
                    height: 40,
                  ),
                  title: new Text(
                    'Referee',
                    style: TextStyle(color: themeBackGroundColor),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: new Image.asset(
                    'assets/iconB.png',
                    height: 40,
                  ),
                  title: new Text(
                    'BTeam',
                    style: TextStyle(color: themeBackGroundColor),
                  ),
                ),
              ],
            );
          },
        ),
        body: Consumer<MatchDetailsSettingModel>(
          builder: (context, model, child) {
            return Stack(
              children: <Widget>[
                _buildOffstage(
                    0, TeamDetailsSettingPage(model.match, 0), model),
                _buildOffstage(1, RefereeDetailsPage(model.match, 1), model),
                _buildOffstage(
                    2, TeamDetailsSettingPage(model.match, 2), model),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOffstage(
      int index, Widget page, MatchDetailsSettingModel model) {
    return Offstage(
      offstage: index != model.index,
      child: new TickerMode(
        enabled: index == model.index,
        child: page,
      ),
    );
  }
}
