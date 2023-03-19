import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp3/api/api_url.dart';
import 'package:weatherapp3/model/weather_data.dart';
import 'package:weatherapp3/model/weather_data_current.dart';
import 'package:weatherapp3/model/weather_data_daily.dart';
import 'package:weatherapp3/model/weather_data_hourly.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
        WeatherDataCurrent.fromjson(jsonString),
        WeatherDataHourly.fromjson(jsonString),
        WeatherDataDaily.fromjson(jsonString));
    return weatherData!;
  }
}