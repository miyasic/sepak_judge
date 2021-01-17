class Team {
  Team({name, members});
  String name = '';
  List<Player> members = [];
  String captain = '';
}

class Player {
  Player({name, number});
  String name = '';
  String number = '';
}
