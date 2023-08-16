import 'package:flutter/material.dart';
import 'package:loudweather/Core/Utils/static_files.dart';
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
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff060720),
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: Column(
          children: [
            SizedBox(height: myHeight * 0.02),
            Text(
              widget.weatherModel[StaticFile.myLocationIndex].name.toString(),
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
            SizedBox(height: myHeight * 0.001),
            Text(
              '18 January 2023'.toString(),
              style:
                  TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.5)),
            ),
            SizedBox(height: myHeight * 0.03),
            Container(
              height: myHeight * 0.05,
              width: myWidth * 0.6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 21, 85, 169),
                              Color.fromARGB(255, 44, 162, 246),
                            ])),
                        child: const Center(
                          child: Text(
                            'Forecast',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'Air Quality',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: myHeight * 0.05),
            Image.asset(
              widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!
                  .mainImg
                  .toString(),
              height: myHeight * 0.3,
              width: myWidth * 0.8,
            ),
            SizedBox(height: myHeight * 0.05),
            SizedBox(
              height: myHeight * 0.08,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            'Temp',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                          Text(
                            widget.weatherModel[StaticFile.myLocationIndex]
                                .weeklyWeather![0]!.mainTemp
                                .toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            'Wind',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                          Text(
                            widget.weatherModel[StaticFile.myLocationIndex]
                                .weeklyWeather![0]!.mainWind
                                .toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            'Humidity',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                          Text(
                            widget.weatherModel[StaticFile.myLocationIndex]
                                .weeklyWeather![0]!.mainHumidity
                                .toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            SizedBox(height: myHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.03),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                  Text(
                    'View Full Report',
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ],
              ),
            ),
            SizedBox(height: myHeight * 0.02),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: myWidth * 0.03, bottom: myHeight * 0.03),
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
                                    Color.fromARGB(255, 21, 85, 169),
                                    Color.fromARGB(255, 44, 162, 246),
                                  ])
                                : null),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                widget.weatherModel[StaticFile.myLocationIndex]
                                    .weeklyWeather![0]!.allTime!.img![index]
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
            ),
          ],
        ),
      ),
    ));
  }
}
