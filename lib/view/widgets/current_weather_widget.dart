import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp3/utils/custom_colors.dart';
import 'package:weatherapp3/model/weather_data_current.dart';
import 'package:weatherapp3/view/widgets/header_widget.dart';
import 'package:weatherapp3/view/widgets/extra_weather_info.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CurrentWeatherWidget extends GetView {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeatherWidget({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/jpg_images/sky.jpg'),
            colorFilter:
                ColorFilter.mode(CustomColors.filterColor, BlendMode.darken),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      child: Stack(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: const HeaderWidget(),
        ),
        Align(
          alignment: const Alignment(0.0, 1.0),
          child: SizedBox(
            height: 1,
            width: 10,
            child: OverflowBox(
              minWidth: 0.0,
              maxWidth: MediaQuery.of(context).size.width,
              minHeight: 0.0,
              maxHeight: MediaQuery.of(context).size.height / 2.5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: double.infinity,
                child: Card(
                  color: CustomColors.whiteColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //temperature weather widget
                              temperatureWeatherWidget(),
                              //temperature more details windSpeed, humidity , cloud
                              currentWeatherMoreDetailsWidget(),
                              const SizedBox(height: 10),
                              //comfort level
                              comfortLevel(),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget temperatureWeatherWidget() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 150,
            width: 150,
            child: Image.asset(
                "assets/images/${weatherDataCurrent.current.weather![0].icon}.png",
                height: 80,
                width: 80),
          ),
          Container(height: 60, width: 2, color: CustomColors.dividerLine),
          Text('${weatherDataCurrent.current.temp?.round()}°',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 68,
                  color: CustomColors.textColorBlack)),
          Container(
            alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(3),
              width: 70,
              height: 100,
              child: Text(
                  textAlign: TextAlign.start,
                  '${weatherDataCurrent.current.weather![0].description}',
                  style: const TextStyle(
                      fontSize: 12, color: CustomColors.textColorGrey))),
        ]);
  }

  Widget currentWeatherMoreDetailsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ExtraWeatherInfo(
            weatherDataCurrent: weatherDataCurrent,
            image: Image.asset('assets/icons/wind Speed.png',
                height: 30, width: 30),
            text: Text('${weatherDataCurrent.current.windSpeed?.round()} km/h',
                style: const TextStyle(
                    color: CustomColors.textColorGrey,
                    fontSize: 17,
                    fontWeight: FontWeight.bold))),
        ExtraWeatherInfo(
            weatherDataCurrent: weatherDataCurrent,
            image:
                Image.asset('assets/icons/humidity.png', height: 30, width: 30),
            text: Text('${weatherDataCurrent.current.humidity} %',
                style: const TextStyle(
                    color: CustomColors.textColorGrey,
                    fontSize: 17,
                    fontWeight: FontWeight.bold))),
        ExtraWeatherInfo(
            weatherDataCurrent: weatherDataCurrent,
            image:
                Image.asset('assets/icons/clouds.png', height: 30, width: 30),
            text: Text('${weatherDataCurrent.current.clouds} %',
                style: const TextStyle(
                    color: CustomColors.textColorGrey,
                    fontSize: 17,
                    fontWeight: FontWeight.bold)))
      ],
    );
  }

  Widget comfortLevel() {
    return SizedBox(
      height: 175,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SleekCircularSlider(
            min: 0,
            max: 100,
            initialValue: weatherDataCurrent.current.humidity!.toDouble(),
            appearance: CircularSliderAppearance(
                infoProperties: InfoProperties(
                    bottomLabelText: " Humidity ",
                    bottomLabelStyle:
                        const TextStyle(color: CustomColors.textColorBlack,fontSize: 20)),
                size: 140,
                animationEnabled: true,
                customWidths: CustomSliderWidths(
                    trackWidth: 9, progressBarWidth: 12, handlerSize: 0),
                customColors: CustomSliderColors(
                    trackColor: CustomColors.firstGradientColor.withAlpha(100),
                    progressBarColors: [
                      CustomColors.firstGradientColor,
                      CustomColors.secondGradientColor
                    ])),
          ),
          SleekCircularSlider(
            min: 0,
            max: 100,
            initialValue: weatherDataCurrent.current.uvi!.toDouble(),
            appearance: CircularSliderAppearance(
                infoProperties: InfoProperties(
                    bottomLabelText: "Rain",
                    bottomLabelStyle:
                        const TextStyle(color: CustomColors.textColorBlack,fontSize: 20)),
                size: 140,
                animationEnabled: true,
                customWidths: CustomSliderWidths(
                    trackWidth: 9, progressBarWidth: 12, handlerSize: 0),
                customColors: CustomSliderColors(
                    trackColor: CustomColors.firstGradientColor.withAlpha(100),
                    progressBarColors: [
                      CustomColors.firstGradientColor,
                      CustomColors.secondGradientColor
                    ])),
          )
        ],
      ),
    );
  }
}
