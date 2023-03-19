import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp3/model/weather_data_hourly.dart';
import 'package:weatherapp3/utils/custom_colors.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;

  const HourlyWeatherWidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: const Text(
              '  Hourly Weather  ',
              style: TextStyle(fontSize: 17),
            )),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 350,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: CustomColors.dividerLine.withAlpha(50)),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: weatherDataHourly.hourly.length > 24
              ? 24
              : weatherDataHourly.hourly.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.all(0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15),color: CustomColors.dividerLine.withAlpha(25)),
              child: HourlyDetails(
                timeStamp: weatherDataHourly.hourly[index].dt!,
                weatherIcon: weatherDataHourly.hourly[index].weather![0].icon!,
                temp: weatherDataHourly.hourly[index].temp!,
              ),
            );
          }),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  final double temp;
  final int timeStamp;
  final String weatherIcon;

  String getTime(timeStamp) {
    DateTime time =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000, isUtc: true);
    String x = DateFormat('jm').format(time);
    return x;
  }

  const HourlyDetails({
    Key? key,
    required this.temp,
    required this.weatherIcon,
    required this.timeStamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(getTime(timeStamp)),
            Container(
                padding: const EdgeInsets.all(2),
                child: Image.asset('assets/images/$weatherIcon.png',
                    height: 40, width: 40)),
            Text(temp.round().toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          ]),
    );
  }
}
