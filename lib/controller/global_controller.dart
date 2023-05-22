import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp3/api/fetch_weather.dart';
import 'package:weatherapp3/model/weather_data.dart';
import 'package:weatherapp3/utils/custom_colors.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  final weatherData = WeatherData().obs;
  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  RxInt getIndex() {
    return _currentIndex;
  }

  WeatherData getData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
    print(" ++++++++++++ TEST +++++++++++++");
  }

  Future getLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isServiceEnabled == false) {
      const AlertDialog(
        icon: Icon(Icons.location_off),
        iconColor: CustomColors.whiteColor,
        content: Text(' Location Service is not enabled '),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        contentTextStyle: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            backgroundColor: CustomColors.cardColor,
            color: CustomColors.textColorBlack),
      );
    }
    LocationPermission localPermission = await Geolocator.checkPermission();
    if (localPermission == LocationPermission.deniedForever) {
      return Future.error("Location Permission is denied forever");
    } else if (localPermission == LocationPermission.denied) {
      localPermission = await Geolocator.requestPermission();
      if (localPermission == LocationPermission.denied) {
        return Future.error("Location Permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }
}
