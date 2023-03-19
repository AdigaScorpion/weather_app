import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weatherapp3/controller/global_controller.dart';
import 'package:weatherapp3/utils/custom_colors.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());

  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, lon);
    setState(() {
      city = (placeMark[0].locality ?? placeMark[0].subLocality)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10, right: 30, left: 30),
          child: Text(
            city,
            style: const TextStyle(
                fontSize: 34, fontWeight: FontWeight.bold, height: 2),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Text(
            date,
            style:
                const TextStyle(fontSize: 16, height: 1, color: CustomColors.whiteColor),
          ),
        )
      ],
    );
  }
}
