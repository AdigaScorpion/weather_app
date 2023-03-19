class WeatherDataHourly {
  List<Hourly> hourly;
  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromjson(Map<String, dynamic> json) =>
      WeatherDataHourly(hourly: List<Hourly>.from(json['hourly'].map((e)=>Hourly.fromJson(e))));
}

class Hourly {
  int? dt;
  double? temp;
  int? pressure;
  int? humidity;
  double? uvi;
  int? clouds;
  double? windSpeed;
  List<Weather>? weather;


  Hourly({
    this.dt,
    this.temp,
    this.pressure,
    this.humidity,
    this.uvi,
    this.clouds,
    this.windSpeed,
    this.weather,

  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    dt: json['dt'] as int?,
    temp: (json['temp'] as num?)?.toDouble(),
    pressure: json['pressure'] as int?,
    humidity: json['humidity'] as int?,
    uvi: (json['uvi'] as num?)?.toDouble(),
    clouds: json['clouds'] as int?,
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),

  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'temp': temp,
    'pressure': pressure,
    'humidity': humidity,
    'uvi': uvi,
    'clouds': clouds,
    'wind_speed': windSpeed,
    'weather': weather?.map((e) => e.toJson()).toList(),

  };
}
class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json['id'] as int?,
    main: json['main'] as String?,
    description: json['description'] as String?,
    icon: json['icon'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}
