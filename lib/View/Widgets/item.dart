import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Core/Utils/global_methods.dart';
import '../../Models/hourly_forecast-model.dart';
import '../../ViewModel/cubits/weather_cubit/weather_cubit.dart';

class Item extends StatelessWidget {
  final ForecastDay day;
  const Item({super.key, required this.day});
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidget = MediaQuery.of(context).size.width;
    var weatherCubit = WeatherCubit.get(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: myHeight * 0.015, horizontal: myWidget * 0.07),
      child: Container(
        height: myHeight * 0.11,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('EEEE').format(DateTime.parse(day.date)),
                  style: const TextStyle(color: Colors.white, fontSize: 17.5),
                ),
                Text(
                  GlobalMethods.formattedDateText(day.date, true),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 12.5),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  day.day.maxtempC.toInt().toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                ),
                const Text(
                  '°C \n ',
                  style: TextStyle(color: Colors.white, fontSize: 17.5),
                ),
              ],
            ),
            Image.asset(
              weatherCubit.weatherImage(day.day.condition.text),
              height: myHeight * 0.08,
              width: myWidget * 0.16,
            )
          ],
        ),
      ),
    );
  }
}
