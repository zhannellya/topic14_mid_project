import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weather_console_app/city.dart';

void main(List<String> arguments) {
  final googleApi = GoogleApi();

  googleApi.getCityPlaceId(
      cityName: 'Alma', key: 'AIzaSyDJ-biU5k2YpGbhlB7kNTl9RQaseN8uzuM');
}

class WeatherApi {
  getWeatherApi(final key, final cityName) async {
    final url =
        'https://api.weatherapi.com/v1/current.json?key=$key&q=$cityName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print('api қате шықты');
      return;
    }

    final Map<String, dynamic> jsonResponse =
        Map.castFrom(jsonDecode(response.body));

    final city = City.getLocationfromJson(jsonResponse);
    print('Current Country ${city.country}');
  }
}

class GoogleApi {
  void getCityPlaceId({final cityName, final key}) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$cityName&key=$key';
    print('url of cityName: $url');

    final response = await http.get(Uri.parse(url));

    final Map<String, dynamic> jsonResponse =
        Map.castFrom(jsonDecode(response.body));

    final List<dynamic> predictions = jsonResponse['predictions'];

    for (var item in predictions) {
      final String desc = item['description'];

      if (desc.contains('Kazakhstan')) {
        String placeId = item['place_id'];
        print('placeId: $placeId');

        getCityDetail(placeId: placeId, key: key);
      }
    }
  }

  void getCityDetail({final placeId, final key}) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    print('url of placeId: $url');

    final response = await http.get(Uri.parse(url));

    final Map<String, dynamic> jsonResponse =
        Map.castFrom(jsonDecode(response.body));

    final Map<String, dynamic> result = jsonResponse['result'];

    String cityUrl = result['url'];
    print('cityUrl $cityUrl');
  }
}
