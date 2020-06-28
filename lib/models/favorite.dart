class Favorite {
  int id;
  String stateAbbr;
  String city;

  Favorite({ this.id, this.stateAbbr, this.city });

  Favorite.fromMap(dynamic obj) {
    this.id = obj["id"];
    this.stateAbbr = obj["state"];
    this.city = obj["city"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["state"] = stateAbbr;
    map["city"] = city;

    return map;
  }
}
