import 'package:flutter/material.dart';

import '../../../Core/Utils/global_methods.dart';
import '../../../Models/forecast_weather_model.dart';
import '../../../ViewModel/cubits/weather_cubit/weather_cubit.dart';

class HourlyWeatherSection extends StatelessWidget {
  final ForecastWeather forecastWeather;
  const HourlyWeatherSection({super.key, required this.forecastWeather});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    var weatherCubit = WeatherCubit.get(context);
    return Column(
      children: [
        SizedBox(
          height: myHeight * 0.2,
          width: myWidth,
          child: Padding(
            padding: EdgeInsets.only(left: myWidth * 0.03),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: forecastWeather.forecast.forecastDay[0].hour.length,
              itemBuilder: (context, index) {
                bool isTime = weatherCubit.findTime(
                    forecastWeather.forecast.forecastDay[0].hour[index].time);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: myWidth * 0.02),
                  child: Container(
                    width: myWidth * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: isTime != true
                            ? Colors.white.withOpacity(0.05)
                            : null,
                        gradient: isTime
                            ? const LinearGradient(
                                colors: [
                                  // Color.fromARGB(255, 21, 85, 169),
                                  // Color.fromARGB(255, 44, 162, 246),
                                  Color(0xff955cd1),
                                  Color(0xff3fa2fa),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.2, 0.85],
                              )
                            : null),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: myWidth * 0.05),
                            Text(
                              forecastWeather
                                  .forecast.forecastDay[0].hour[index].tempC
                                  .toInt()
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 27.5, color: Colors.white),
                            ),
                            const Text(
                              '°C \n ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        Image.asset(
                          weatherCubit.weatherImage(forecastWeather.forecast
                              .forecastDay[0].hour[index].condition.text
                              .trim()
                              .toLowerCase()),
                          height: myHeight * 0.06,
                        ),
                        Text(
                          GlobalMethods.formattedDateText(
                              forecastWeather
                                  .forecast.forecastDay[0].hour[index].time
                                  .toString(),
                              false),
                          style: const TextStyle(
                              fontSize: 17.5, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
