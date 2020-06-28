import 'package:covidnearby/models/country_data.dart';
import 'package:covidnearby/models/city_data.dart';
import 'package:covidnearby/models/state_data.dart';
import 'package:covidnearby/utils/http_wrapper.dart';

class DataRequester {
  final HTTPWrapper network = HTTPWrapper();

  Future<CityData> getCityCases(stateAbbr, city) async {
    var response = await network.getData('https://brasil.io/api/dataset/covid19/caso_full/data?state=$stateAbbr&city=$city&is_last=True');

    return CityData.fromJson(response['results'][0]);
  }

  Future<StateData> getStateCases(stateAbbr) async {
    var response = await network.getData('https://brasil.io/api/dataset/covid19/caso_full/data?state=$stateAbbr&place_type=state&is_last=True');

    return StateData.fromJson(response['results'][0]);
  }

  Future<CountryData> getCountryCases(countryAbbr) async {
    var response = await network.getData('https://corona-api.com/countries/$countryAbbr');

    return CountryData.fromJson(response['data']);
  }
}
