import 'package:flutter/material.dart';
import 'package:loudweather/Models/weather_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../Core/Utils/static_files.dart';
import '../Widgets/item.dart';

class ForecastScreen extends StatefulWidget {
  List<WeatherModel> weatherModel = [];
  ForecastScreen({super.key, required this.weatherModel});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
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
        child: Column(children: [
          SizedBox(height: myHeight * 0.03),
          const Text(
            'Forecast Report',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          SizedBox(height: myHeight * 0.05),
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
          SizedBox(
            height: myHeight * 0.15,
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
                                      .weatherModel[StaticFile.myLocationIndex]
                                      .weeklyWeather![0]!
                                      .allTime!
                                      .hour![index]
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  widget
                                      .weatherModel[StaticFile.myLocationIndex]
                                      .weeklyWeather![0]!
                                      .allTime!
                                      .temps![index]
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: myWidth * 0.04),
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
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Item(
                  item: widget.weatherModel[StaticFile.myLocationIndex]
                      .weeklyWeather![index],
                  day: day[index],
                );
              },
            ),
          )
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
