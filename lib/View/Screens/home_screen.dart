import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loudweather/Core/Utils/static_files.dart';
import 'package:loudweather/ViewModel/cubits/weather_cubit/weather_cubit.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../Models/weather_model.dart';

class HomeScreen extends StatefulWidget {
  List<WeatherModel> weatherModel = [];
  HomeScreen({super.key, required this.weatherModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await scrollToIndex();
    });
    findMyLocationIndex();
    super.initState();
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  DateTime time = DateTime.now();
  bool complete1 = false;
  bool complete2 = false;
  int hourIndex = 0;
  findMyLocationIndex() {
    for (int i = 0; i < widget.weatherModel.length; i++) {
      if (widget.weatherModel[i].name == StaticFile.myLocation) {
        setState(() {
          StaticFile.myLocationIndex = i;
          complete1 = true;
        });
        break;
      }
    }
    findHourIndex();
  }

  findHourIndex() {
    String myTime;
    myTime = time.hour.toString();
    if (myTime.length == 1) {
      myTime = '0$myTime';
    }
    for (int i = 0;
        i <
            widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!
                .allTime!.hour!.length;
        i++) {
      if (widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!
              .allTime!.hour![i]!
              .substring(0, 2)
              .toString() ==
          myTime) {
        setState(() {
          hourIndex = i;
          complete2 = true;
        });
        break;
      }
    }
  }

  scrollToIndex() async {
    itemScrollController.scrollTo(
        index: hourIndex,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    var weatherCubit = WeatherCubit.get(context);
    weatherCubit.getCurrentWeather();
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff060720),
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: Column(
          children: [
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is LoadedCurrentWeather) {
                  return Container(
                    height: myHeight * 0.78,
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
                              state.currentWeather.name,
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
                                state.currentWeather.weather[0].main),
                            height: myHeight * 0.3,
                            width: myWidth * 0.8,
                          ),
                        ),
                        SizedBox(height: myHeight * 0.01),
                        Column(
                          children: [
                            Text(
                              state.currentWeather.main.temp.toString(),
                              style: const TextStyle(
                                  fontSize: 50, color: Colors.white),
                            ),
                            Text(
                              state.currentWeather.weather[0].main,
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                            Text(
                              state.currentWeather.weather[0].description,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
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
                                        state.currentWeather.wind.speed
                                            .toString(),
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
                                      '${state.currentWeather.main.humidity.toString()}%',
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
                                        '${state.currentWeather.clouds.all.toString()}%',
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    'View Full Report',
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ],
              ),
            ),
            SizedBox(height: myHeight * 0.01),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                return SizedBox(
                  height: myHeight * 0.12,
                  width: myWidth,
                  child: Padding(
                    padding: EdgeInsets.only(left: myWidth * 0.03),
                    child: ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.weatherModel[StaticFile.myLocationIndex]
                          .weeklyWeather![0]!.allTime!.hour!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: myWidth * 0.02,
                            vertical: myHeight * 0.01,
                          ),
                          child: Container(
                            width: myWidth * 0.35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: hourIndex == index
                                    ? null
                                    : Colors.white.withOpacity(0.05),
                                gradient: hourIndex == index
                                    ? const LinearGradient(colors: [
                                        // Color.fromARGB(255, 21, 85, 169),
                                        // Color.fromARGB(255, 44, 162, 246),
                                        Color(0xff955cd1),
                                        Color(0xff3fa2fa),
                                      ])
                                    : null),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    widget
                                        .weatherModel[
                                            StaticFile.myLocationIndex]
                                        .weeklyWeather![0]!
                                        .allTime!
                                        .img![index]
                                        .toString(),
                                    height: myHeight * 0.04,
                                  ),
                                  SizedBox(width: myWidth * 0.04),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget
                                            .weatherModel[
                                                StaticFile.myLocationIndex]
                                            .weeklyWeather![0]!
                                            .allTime!
                                            .hour![index]
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Text(
                                        widget
                                            .weatherModel[
                                                StaticFile.myLocationIndex]
                                            .weeklyWeather![0]!
                                            .allTime!
                                            .temps![index]
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
