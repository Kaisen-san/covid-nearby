import 'package:covidnearby/models/covid_data.dart';
import 'package:covidnearby/utils/network_helper.dart';

class CovidRequest {
  String stateAbbreviation;
  String stateCounty;

  CovidRequest(this.stateAbbreviation, this.stateCounty);

  Future<CovidData> getFullCases() async {
    NetworkHelper netHelper = NetworkHelper(url: 'https://brasil.io/api/dataset/covid19/caso_full/data?state=${stateAbbreviation}&city=${stateCounty}&is_last=True');

    return CovidData.fromJson((await netHelper.getData())['results'][0]);
  }

  Future<CovidData> getStateCases() async {
    NetworkHelper netHelper = NetworkHelper(url: 'https://brasil.io/api/dataset/covid19/caso_full/data?state=${stateAbbreviation}&place_type=state&is_last=True');

    return CovidData.fromJson((await netHelper.getData())['results'][0]);
  }
}
