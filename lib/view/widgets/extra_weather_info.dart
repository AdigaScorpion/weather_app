import 'package:flutter/material.dart';
import 'package:weatherapp3/model/weather_data_current.dart';
import 'package:weatherapp3/utils/custom_colors.dart';

class ExtraWeatherInfo extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  final Image image;
  final Text text;

  const ExtraWeatherInfo(
      {Key? key,
      required this.weatherDataCurrent,
      required this.image,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(8.0),
        height: 70,
        width: 100,
        decoration: BoxDecoration(
            color: CustomColors.cardColor,
            borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[image, text],
        ));
  }
}
