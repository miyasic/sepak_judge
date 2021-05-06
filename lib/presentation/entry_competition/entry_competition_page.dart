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
}
