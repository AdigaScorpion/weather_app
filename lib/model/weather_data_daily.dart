class WeatherDataDaily {
  List<Daily> daily;
  WeatherDataDaily({required this.daily});

  factory WeatherDataDaily.fromjson(Map<String, dynamic> json) =>
      WeatherDataDaily(daily: List<Daily>.from(json['daily'].map((e)=>Daily.fromJson(e))));
}

class Daily {
  int? dt;
  Temp? temp;
  int? pressure;
  int? humidity;
  double? windSpeed;
  List<Weather>? weather;
  int? clouds;
  double? uvi;

  Daily({
    this.dt,
    this.temp,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.weather,
    this.clouds,
    this.uvi,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    dt: json['dt'] as int?,
    temp: json['temp'] == null
        ? null
        : Temp.fromJson(json['temp'] as Map<String, dynamic>),
    pressure: json['pressure'] as int?,
    humidity: json['humidity'] as int?,
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
    clouds: json['clouds'] as int?,
    uvi: (json['uvi'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'temp': temp?.toJson(),
    'pressure': pressure,
    'humidity': humidity,
    'wind_speed': windSpeed,
    'weather': weather?.map((e) => e.toJson()).toList(),
    'clouds': clouds,
    'uvi': uvi,
  };
}
class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
    day: (json['day'] as num?)?.toDouble(),
    night: (json['night'] as num?)?.toDouble(),
    eve: (json['eve'] as num?)?.toDouble(),
    morn: (json['morn'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'night': night,
    'eve': eve,
    'morn': morn,
  };
}
class Temp {
  double? day;
  double? min;
  double? max;

  Temp({this.day, this.min, this.max});

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    day: (json['day'] as num?)?.toDouble(),
    min: (json['min'] as num?)?.toDouble(),
    max: (json['max'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'min': min,
    'max': max,
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

