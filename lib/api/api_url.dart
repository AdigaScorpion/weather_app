import 'package:weatherapp3/api/api_key.dart';

String apiURL(var lat, var lon) {
  String url;
  url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$apiKey&units=metric";
  return url;
}


