class covid_Favorites {
  int id;
  String State;
  String Province;


  covid_Favorites(
     // this.id,
      this.State,
      this.Province,

      );

  covid_Favorites.fromMap(dynamic obj) {
    this.id= obj["id"];
    this.State = obj["state"];
    this.Province = obj["province"];

  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["state"] = State;
    map["province"] = Province;

    return map;
  }

  //Getters
  int get getid => id;
  String get getState => State;
  String get getProvince => Province;

}