import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp3/utils/custom_colors.dart';
import 'package:weatherapp3/model/weather_data_daily.dart';
import 'package:weatherapp3/controller/global_controller.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;

  DailyDataForecast({Key? key, required this.weatherDataDaily})
      : super(key: key);
  final RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: CustomColors.dividerLine.withAlpha(50),
            borderRadius: BorderRadius.circular(20)),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: const Text(' Next Days WeatherForecast ',
                style: TextStyle(
                    color: CustomColors.textColorBlack, fontSize: 17)),
          ),
          const SizedBox(height: 7),
          dailyList(),
        ]));
  }

  Widget dailyList() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherDataDaily.daily.length,
          itemBuilder: (context, index) {
            return Obx(
              (() => GestureDetector(
                    onTap: () {
                      cardIndex.value = index;
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: cardIndex.value == index
                              ? const LinearGradient(colors: [
                                  CustomColors.firstGradientColor,
                                  CustomColors.secondGradientColor
                                ])
                              : null),
                      child: DailyDetails(
                        timeStamp: getDay(weatherDataDaily.daily[index].dt),
                        index: index,
                        cardIndex: cardIndex.toInt(),
                        min: weatherDataDaily.daily[index].temp!.min!.round(),
                        max: weatherDataDaily.daily[index].temp!.max!.round(),
                        weatherIcon:
                            'assets/images/${weatherDataDaily.daily[index].weather![0].icon}.png',
                      ),
                    ),
                  )),
            );
          }),
    );
  }
}

String getDay(dt) {
  DateTime day = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  String x = DateFormat('EEE').format(day);
  return x;
}

class DailyDetails extends StatelessWidget {
  final int index;
  final int cardIndex;
  final String timeStamp;
  final String weatherIcon;
  final int min;
  final int max;

  const DailyDetails(
      {Key? key,
      required this.index,
      required this.cardIndex,
      required this.timeStamp,
      required this.weatherIcon,
      required this.min,
      required this.max})
      : super(key: key);

  String getTime(timeStamp) {
    DateTime time =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000, isUtc: true);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColors.dividerLine.withAlpha(50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            timeStamp,
            style: TextStyle(
                color: cardIndex == index
                    ? CustomColors.whiteColor
                    : CustomColors.textColorBlack),
          ),
          SizedBox(child: Image.asset(weatherIcon, height: 40, width: 40)),
          Row(children: <Widget>[
            Text(
              '$max° / $min°',
              style: TextStyle(
                  fontSize: 16,
                  color: cardIndex == index
                      ? CustomColors.whiteColor
                      : CustomColors.textColorGrey),
            )
          ]),
        ],
      ),
    );
  }
}
