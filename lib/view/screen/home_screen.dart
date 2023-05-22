import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp3/view/widgets/daily_data_forecast.dart';
import 'package:weatherapp3/controller/global_controller.dart';
import 'package:weatherapp3/view/widgets/hourly_weather_widget.dart';
import 'package:weatherapp3/view/widgets/current_weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => globalController.checkLoading().isTrue
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/lottie/weather.json',
                        height: 200, width: 200),
                    const CircularProgressIndicator(),
                  ],
                ),
              )
            : GetBuilder<GlobalController>(
                builder: (controller) => Column(children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: CurrentWeatherWidget(
                          weatherDataCurrent:
                              globalController.getData().getCurrentWeather())),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 170, right: 5, left: 5),
                      child: ListView(children: <Widget>[
                        const SizedBox(height: 15),
                        DailyDataForecast(
                            weatherDataDaily:
                                globalController.getData().getDailyWeather()),
                        HourlyWeatherWidget(
                            weatherDataHourly:
                                globalController.getData().getHourlyWeather()),
                      ]),
                    ),
                  )
                ]),
              ),
      ),
    );
  }
}
