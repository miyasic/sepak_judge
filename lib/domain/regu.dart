class Regu {
  Regu({name, members});
  String name = '';
  List<ReguMembers> members = [];
  String captain = '';
  bool isInputCompleted = false;
}

class ReguMembers {
  ReguMembers({this.name, this.number});
  String name = '';
  String number = '';
}
