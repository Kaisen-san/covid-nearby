class CityData {
  String stateAbbreviation;
  String city;
  DateTime date;
  double lastAvailableDeathRate;
  int lastAvailableConfirmed;
  int lastAvailableDeaths;
  int newConfirmed;
  int newDeaths;

  CityData({
    this.stateAbbreviation,
    this.city,
    this.date,
    this.lastAvailableDeathRate,
    this.lastAvailableConfirmed,
    this.lastAvailableDeaths,
    this.newConfirmed,
    this.newDeaths
  });

  CityData.fromJson(Map<String, dynamic> json) {
    stateAbbreviation = json['state'];
    city = json['city'];
    date = DateTime.parse(json['date']);
    lastAvailableDeathRate = json['last_available_death_rate'];
    lastAvailableConfirmed = json['last_available_confirmed'];
    lastAvailableDeaths = json['last_available_deaths'];
    newConfirmed = json['new_confirmed'];
    newDeaths = json['new_deaths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['state'] = this.stateAbbreviation;
    data['city'] = this.city;
    data['date'] = this.date.toString();
    data['last_available_death_rate'] = this.lastAvailableDeathRate;
    data['last_available_confirmed'] = this.lastAvailableConfirmed;
    data['last_available_deaths'] = this.lastAvailableDeaths;
    data['new_confirmed'] = this.newConfirmed;
    data['new_deaths'] = this.newDeaths;

    return data;
  }
}
