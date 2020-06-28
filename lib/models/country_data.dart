class CountryData {
  String name;
  String code;
  LatestData latestData;
  List<Timeline> timeline;

  CountryData({
    this.name,
    this.code,
    this.latestData,
    this.timeline
  });

  CountryData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    latestData = json['latest_data'] != null ? new LatestData.fromJson(json['latest_data']) : null;

    if (json['timeline'] != null) {
      timeline = new List<Timeline>();
      json['timeline'].forEach((v) {
        timeline.add(new Timeline.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['code'] = this.code;

    if (this.latestData != null) {
      data['latest_data'] = this.latestData.toJson();
    }

    if (this.timeline != null) {
      data['timeline'] = this.timeline.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class LatestData {
  int deaths;
  int confirmed;
  int recovered;
  int critical;
  Calculated calculated;

  LatestData({
    this.deaths,
    this.confirmed,
    this.recovered,
    this.critical,
    this.calculated
  });

  LatestData.fromJson(Map<String, dynamic> json) {
    deaths = json['deaths'];
    confirmed = json['confirmed'];
    recovered = json['recovered'];
    critical = json['critical'];
    calculated = json['calculated'] != null ? new Calculated.fromJson(json['calculated']) : null;
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

  Calculated({
    this.deathRate,
    this.recoveryRate,
  });

  Calculated.fromJson(Map<String, dynamic> json) {
    deathRate = json['death_rate'];
    recoveryRate = json['recovery_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['death_rate'] = this.deathRate;
    data['recovery_rate'] = this.recoveryRate;

    return data;
  }
}

class Timeline {
  String date;
  int deaths;
  int confirmed;
  int active;
  int recovered;
  int newConfirmed;
  int newRecovered;
  int newDeaths;

  Timeline({
    this.date,
    this.deaths,
    this.confirmed,
    this.active,
    this.recovered,
    this.newConfirmed,
    this.newRecovered,
    this.newDeaths
  });

  Timeline.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    deaths = json['deaths'];
    confirmed = json['confirmed'];
    active = json['active'];
    recovered = json['recovered'];
    newConfirmed = json['new_confirmed'];
    newRecovered = json['new_recovered'];
    newDeaths = json['new_deaths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['date'] = this.date;
    data['deaths'] = this.deaths;
    data['confirmed'] = this.confirmed;
    data['active'] = this.active;
    data['recovered'] = this.recovered;
    data['new_confirmed'] = this.newConfirmed;
    data['new_recovered'] = this.newRecovered;
    data['new_deaths'] = this.newDeaths;

    return data;
  }
}
