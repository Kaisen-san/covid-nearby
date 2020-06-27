class BrazilData {
  Coordinates coordinates;
  String name;
  String code;
  int population;
  String updatedAt;
  Today today;
  LatestData latestData;
  List<Timeline> timeline;

  BrazilData(
      {this.coordinates,
        this.name,
        this.code,
        this.population,
        this.updatedAt,
        this.today,
        this.latestData,
        this.timeline});

  BrazilData.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
    name = json['name'];
    code = json['code'];
    population = json['population'];
    updatedAt = json['updated_at'];
    today = json['today'] != null ? new Today.fromJson(json['today']) : null;
    latestData = json['latest_data'] != null
        ? new LatestData.fromJson(json['latest_data'])
        : null;
    if (json['timeline'] != null) {
      timeline = new List<Timeline>();
      json['timeline'].forEach((v) {
        timeline.add(new Timeline.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    data['name'] = this.name;
    data['code'] = this.code;
    data['population'] = this.population;
    data['updated_at'] = this.updatedAt;
    if (this.today != null) {
      data['today'] = this.today.toJson();
    }
    if (this.latestData != null) {
      data['latest_data'] = this.latestData.toJson();
    }
    if (this.timeline != null) {
      data['timeline'] = this.timeline.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class Coordinates {
  int latitude;
  int longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Today {
  int deaths;
  int confirmed;

  Today({this.deaths, this.confirmed});

  Today.fromJson(Map<String, dynamic> json) {
    deaths = json['deaths'];
    confirmed = json['confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deaths'] = this.deaths;
    data['confirmed'] = this.confirmed;
    return data;
  }
}

class LatestData {
  int deaths;
  int confirmed;
  int recovered;
  int critical;
  Calculated calculated;

  LatestData(
      {this.deaths,
        this.confirmed,
        this.recovered,
        this.critical,
        this.calculated});

  LatestData.fromJson(Map<String, dynamic> json) {
    deaths = json['deaths'];
    confirmed = json['confirmed'];
    recovered = json['recovered'];
    critical = json['critical'];
    calculated = json['calculated'] != null
        ? new Calculated.fromJson(json['calculated'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deaths'] = this.deaths;
    data['confirmed'] = this.confirmed;
    data['recovered'] = this.recovered;
    data['critical'] = this.critical;
    if (this.calculated != null) {
      data['calculated'] = this.calculated.toJson();
    }
    return data;
  }
}

class Calculated {
  double deathRate;
  double recoveryRate;
  Null recoveredVsDeathRatio;
  int casesPerMillionPopulation;

  Calculated(
      {this.deathRate,
        this.recoveryRate,
        this.recoveredVsDeathRatio,
        this.casesPerMillionPopulation});

  Calculated.fromJson(Map<String, dynamic> json) {
    deathRate = json['death_rate'];
    recoveryRate = json['recovery_rate'];
    recoveredVsDeathRatio = json['recovered_vs_death_ratio'];
    casesPerMillionPopulation = json['cases_per_million_population'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['death_rate'] = this.deathRate;
    data['recovery_rate'] = this.recoveryRate;
    data['recovered_vs_death_ratio'] = this.recoveredVsDeathRatio;
    data['cases_per_million_population'] = this.casesPerMillionPopulation;
    return data;
  }
}

class Timeline {
  String updatedAt;
  String date;
  int deaths;
  int confirmed;
  int active;
  int recovered;
  int newConfirmed;
  int newRecovered;
  int newDeaths;
  bool isInProgress;

  Timeline(
      {this.updatedAt,
        this.date,
        this.deaths,
        this.confirmed,
        this.active,
        this.recovered,
        this.newConfirmed,
        this.newRecovered,
        this.newDeaths,
        this.isInProgress});

  Timeline.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updated_at'];
    date = json['date'];
    deaths = json['deaths'];
    confirmed = json['confirmed'];
    active = json['active'];
    recovered = json['recovered'];
    newConfirmed = json['new_confirmed'];
    newRecovered = json['new_recovered'];
    newDeaths = json['new_deaths'];
    isInProgress = json['is_in_progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at'] = this.updatedAt;
    data['date'] = this.date;
    data['deaths'] = this.deaths;
    data['confirmed'] = this.confirmed;
    data['active'] = this.active;
    data['recovered'] = this.recovered;
    data['new_confirmed'] = this.newConfirmed;
    data['new_recovered'] = this.newRecovered;
    data['new_deaths'] = this.newDeaths;
    data['is_in_progress'] = this.isInProgress;
    return data;
  }
}