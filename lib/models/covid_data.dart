class CovidData {
  String state;
  String city;
  DateTime date;
  int epidemiologicalWeek;
  double lastAvailableDeathRate;
  int lastAvailableConfirmed;
  int lastAvailableDeaths;
  int newConfirmed;
  int newDeaths;

  CovidData({
    this.state,
    this.city,
    this.date,
    this.epidemiologicalWeek,
    this.lastAvailableDeathRate,
    this.lastAvailableConfirmed,
    this.lastAvailableDeaths,
    this.newConfirmed,
    this.newDeaths
  });

  CovidData.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    city = json['city'];
    date = DateTime.parse(json['date']);
    epidemiologicalWeek = json['epidemiological_week'];
    lastAvailableDeathRate = json['last_available_death_rate'];
    lastAvailableConfirmed = json['last_available_confirmed'];
    lastAvailableDeaths = json['last_available_deaths'];
    newConfirmed = json['new_confirmed'];
    newDeaths = json['new_deaths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['city'] = this.city;
    data['date'] = this.date.toString();
    data['epidemiological_week'] = this.epidemiologicalWeek;
    data['last_available_death_rate'] = this.lastAvailableDeathRate;
    data['last_available_confirmed'] = this.lastAvailableConfirmed;
    data['last_available_deaths'] = this.lastAvailableDeaths;
    data['new_confirmed'] = this.newConfirmed;
    data['new_deaths'] = this.newDeaths;
    return data;
  }
}
