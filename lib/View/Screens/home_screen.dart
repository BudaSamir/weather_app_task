import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loudweather/ViewModel/cubits/weather_cubit/weather_cubit.dart';

import '../../Core/Utils/global_methods.dart';
import '../../ViewModel/cubits/home_screen_cubit/home_screen_cubit.dart';
import 'forecast_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    var weatherCubit = WeatherCubit.get(context);
    var homeScreenCubit = HomeScreenCubit.get(context);
    weatherCubit.getForecastWeather(homeScreenCubit.cityName);
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff060720),
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: Column(
          children: [
            BlocConsumer<WeatherCubit, WeatherState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadedForecastWeather) {
                  return Container(
                    height: myHeight * 0.7,
                    width: myWidth,
                    padding: EdgeInsets.symmetric(horizontal: myWidth * 0.07),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(60)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff955cd1),
                            Color(0xff3fa2fa),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.2, 0.85],
                        )),
                    child: Column(
                      children: [
                        SizedBox(height: myHeight * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 30,
                              color: Colors.white,
                            ),
                            Text(
                              state.forecastWeather.weatherLocation.name,
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: myHeight * 0.01),
                        DecoratedBox(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 100,
                                spreadRadius: -60,
                                offset: const Offset(20, 0))
                          ]),
                          child: Image.asset(
                            weatherCubit.weatherImage(
                                state.forecastWeather.current.condition.text),
                            height: myHeight * 0.25,
                            width: myWidth * 0.75,
                          ),
                        ),
                        SizedBox(height: myHeight * 0.01),
                        Column(
                          children: [
                            Text(
                              state.forecastWeather.current.tempC
                                  .toInt()
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 50, color: Colors.white),
                            ),
                            Text(
                              state.forecastWeather.current.condition.text,
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          '18 January 2023'.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: myWidth * 0.025),
                          child: Divider(
                            color: Colors.white.withOpacity(0.15),
                            // indent: 10,
                            // endIndent: 10,
                          ),
                        ),
                        SizedBox(
                          height: myHeight * 0.15,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/img/wind.png',
                                        width: myWidth * 0.1,
                                      ),
                                      SizedBox(height: myHeight * 0.015),
                                      Text(
                                        '${state.forecastWeather.current.windKph.toInt().toString()}%',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Text(
                                        'Wind',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Column(children: [
                                    Image.asset(
                                      'assets/img/humidity.png',
                                      width: myWidth * 0.06,
                                    ),
                                    SizedBox(height: myHeight * 0.015),
                                    Text(
                                      '${state.forecastWeather.current.humidity.toString()}%',
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      'Humidity',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white.withOpacity(0.5)),
                                    ),
                                  ])),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/img/rain.png',
                                        width: myWidth * 0.13,
                                      ),
                                      SizedBox(height: myHeight * 0.015),
                                      Text(
                                        '${state.forecastWeather.current.cloud.toString()}%',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Text(
                                        'Chance Of Rain',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: myHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForecastScreen(),
                          ));
                    },
                    child: const Text(
                      'View Full Report',
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: myHeight * 0.01),
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
                        itemCount: state.forecastWeather.forecast.forecastDay[0]
                            .hour.length,
                        itemBuilder: (context, index) {
                          bool isTime = weatherCubit.findTime(state
                              .forecastWeather
                              .forecast
                              .forecastDay[0]
                              .hour[index]
                              .time);
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: myWidth * 0.02),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    state.forecastWeather.forecast
                                        .forecastDay[0].hour[index].tempC
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
          ],
        ),
      ),
    ));
  }
}
