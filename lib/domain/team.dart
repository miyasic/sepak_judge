class Team {
  Team({name, members});
  String name = '';
  List<Player> members = [];
  String captain = '';
  bool isInputCompleted;
}

class Player {
  Player({name, number});
  String name = '';
  String number = '';
}
