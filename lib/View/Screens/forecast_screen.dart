import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Core/Utils/global_methods.dart';
import '../../ViewModel/cubits/home_screen_cubit/home_screen_cubit.dart';
import '../../ViewModel/cubits/weather_cubit/weather_cubit.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    var weatherCubit = WeatherCubit.get(context);
    var homeScreenCubit = HomeScreenCubit.get(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff060720),
      appBar: AppBar(
        backgroundColor: const Color(0xff060720),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Forecast Report',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: Column(children: [
          SizedBox(height: myHeight * 0.015),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: myWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: TextStyle(
                      fontSize: 20, color: Colors.white.withOpacity(0.5)),
                ),
                Text(
                  '18 January 2023',
                  style: TextStyle(
                      fontSize: 15, color: Colors.white.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          SizedBox(height: myHeight * 0.025),
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is LoadedForecastWeather) {
                return SizedBox(
                  height: myHeight * 0.2,
                  width: myWidth,
                  child: Padding(
                    padding: EdgeInsets.only(left: myWidth * 0.03),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state
                          .forecastWeather.forecast.forecastDay[0].hour.length,
                      itemBuilder: (context, index) {
                        bool isTime = weatherCubit.findTime(state
                            .forecastWeather
                            .forecast
                            .forecastDay[0]
                            .hour[index]
                            .time);
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: myWidth * 0.02),
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
                                Text(
                                  state.forecastWeather.forecast.forecastDay[0]
                                      .hour[index].tempC
                                      .toInt()
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 27.5, color: Colors.white),
                                ),
                                Image.asset(
                                  weatherCubit.weatherImage(state
                                      .forecastWeather
                                      .forecast
                                      .forecastDay[0]
                                      .hour[index]
                                      .condition
                                      .text),
                                  height: myHeight * 0.06,
                                ),
                                Text(
                                  GlobalMethods.formattedDateText(state
                                      .forecastWeather
                                      .forecast
                                      .forecastDay[0]
                                      .hour[index]
                                      .time
                                      .toString()),
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
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: myWidth * 0.04, vertical: myHeight * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Forecast Report',
                  style: TextStyle(
                      fontSize: 20, color: Colors.white.withOpacity(0.5)),
                ),
                Image.asset(
                  'assets/icons/5.png',
                  height: myHeight * 0.03,
                  color: Colors.white.withOpacity(0.5),
                ),
              ],
            ),
          ),
          SizedBox(height: myHeight * 0.02),
          // Expanded(
          //   child: ListView.builder(
          //     itemBuilder: (context, index) {
          //       return Item(
          //         item: widget.weatherModel[StaticFile.myLocationIndex]
          //             .weeklyWeather![index],
          //         day: day[index],
          //       );
          //     },
          //   ),
          // )
        ]),
      ),
    ));
  }

  List<int> day = [
    18,
    19,
    20,
    21,
    22,
    23,
    24,
  ];
}
