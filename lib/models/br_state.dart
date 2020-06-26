class BRState {
  String abbreviation;
  String name;
  BRRegion region;
  List<String> counties;

  BRState({this.abbreviation, this.name, this.region, this.counties});

  BRState.fromJson(Map<String, dynamic> json) {
    abbreviation = json['sigla'];
    name = json['nome'];
    region = json['regiao'] != null ? new BRRegion.fromJson(json['regiao']) : null;
    counties = json['municipios'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sigla'] = this.abbreviation;
    data['nome'] = this.name;
    if (this.region != null) {
      data['regiao'] = this.region.toJson();
    }
    data['municipios'] = this.counties;
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
