class BRState {
  String abbreviation;
  String name;
  BRRegion region;
  List<String> cities;

  BRState({ this.abbreviation, this.name, this.region, this.cities });

  BRState.fromJson(Map<String, dynamic> json) {
    abbreviation = json['sigla'];
    name = json['nome'];
    region = json['regiao'] != null ? new BRRegion.fromJson(json['regiao']) : null;
    cities = json['cidades'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sigla'] = this.abbreviation;
    data['nome'] = this.name;
    if (this.region != null) {
      data['regiao'] = this.region.toJson();
    }
    data['cidades'] = this.cities;
    return data;
  }
}

class BRRegion {
  String abbreviation;
  String name;

  BRRegion({this.abbreviation, this.name});

  BRRegion.fromJson(Map<String, dynamic> json) {
    abbreviation = json['sigla'];
    name = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sigla'] = this.abbreviation;
    data['nome'] = this.name;
    return data;
  }
}
