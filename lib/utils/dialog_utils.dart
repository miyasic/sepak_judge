import 'package:flutter/material.dart';

class DialogUtils {
  static Future showAlertDialog(
      {@required String text,
      @required BuildContext context,
      String okText = 'OK',
      @required Function completion}) async {
    await showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                completion();
              },
              child: Text(
                okText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future showOKCancelAlertDialog({
    @required String text,
    BuildContext context,
    String okText = 'OK',
    String cancelText = 'Cancel',
    Function okAction,
    Function cancelAction,
  }) async {
    await showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                cancelAction();
              },
              child: Text(
                cancelText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                okAction();
              },
              child: Text(
                okText,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
