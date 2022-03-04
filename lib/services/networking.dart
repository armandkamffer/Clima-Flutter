import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  static Uri getLocationUri({double latitude, double longitude}) {
    var queryItems = {
      'lat': latitude.toStringAsFixed(7),
      'lon': longitude.toStringAsFixed(7),
      'appid': '9ad8e42829a1607e272814ee5b6af0c0',
      'units': 'metric'
    };
    return getWeatherUri(queryItems: queryItems);
  }

  static Uri getCityUri({String cityName}) {
    var queryItems = {
      'q': cityName,
      'appid': '9ad8e42829a1607e272814ee5b6af0c0',
      'units': 'metric'
    };
    return getWeatherUri(queryItems: queryItems);
  }

  static Uri getWeatherUri({Map<String, String> queryItems}) {
    return Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/data/2.5/weather',
        queryParameters: queryItems);
  }

  static Future<dynamic> getWeatherData({Uri url}) async {
    print(url);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      var decodedJson = jsonDecode(response.body);
      return decodedJson;
    } else {
      print(response.statusCode);
      return Future.error(response.statusCode);
    }
  }
}
