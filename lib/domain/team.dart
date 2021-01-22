class Team {
  Team({name, members});
  String name = '';
  List<Player> members = [];
  String captain = '';
  bool isInputCompleted = false;
}

class Player {
  Player({this.name, this.number});
  String name = '';
  String number = '';
}
