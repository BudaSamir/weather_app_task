import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loudweather/Core/Utils/static_files.dart';

import '../../Models/weather_model.dart';

class SearchScreen extends StatefulWidget {
  List<WeatherModel> weatherModel = [];
  SearchScreen({required this.weatherModel});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
              SizedBox(height: myHeight * 0.03),
              const Text(
                'Pick Location',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(height: myHeight * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                child: Text(
                  'find the area or city that you want to know\n\t\t\t the detailed weather info at this time',
                  style: TextStyle(
                      fontSize: 12, color: Colors.white.withOpacity(0.5)),
                ),
              ),
              SizedBox(height: myHeight * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.06),
                child: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.05),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: myWidth * 0.05),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Image.asset(
                                    'assets/icons/2.2.png',
                                    height: myHeight * 0.025,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5))),
                            ),
                          ),
                        )),
                    SizedBox(width: myWidth * 0.03),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.05),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: myWidth * 0.013,
                              vertical: myHeight * 0.014,
                            ),
                            child: Image.asset(
                              'assets/icons/6.png',
                              height: myHeight * 0.03,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: myHeight * 0.04),
              Expanded(
                child: GridView.custom(
                  padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                  gridDelegate: SliverStairedGridDelegate(
                      mainAxisSpacing: 13,
                      startCrossAxisDirectionReversed: false,
                      pattern: [
                        const StairedGridTile(0.5, 3 / 2.2),
                        const StairedGridTile(0.5, 3 / 2.2),
                      ]),
                  childrenDelegate: SliverChildBuilderDelegate(
                    childCount: widget.weatherModel.length,
                    (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: myWidth * 0.02),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: StaticFile.myLocation ==
                                      widget.weatherModel[index].name.toString()
                                  ? null
                                  : Colors.white.withOpacity(0.05),
                              gradient: StaticFile.myLocation ==
                                      widget.weatherModel[index].name.toString()
                                  ? const LinearGradient(colors: [
                                      Color.fromARGB(255, 21, 85, 169),
                                      Color.fromARGB(255, 44, 162, 246),
                                    ])
                                  : null),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.weatherModel[index]
                                            .weeklyWeather![index]!.mainTemp!
                                            .toString()
                                            .replaceAll('C', ''),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Text(
                                        weather_state[index].toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: myWidth * 0.02),
                                  Image.asset(
                                    widget.weatherModel[index]
                                        .weeklyWeather![index]!.mainImg
                                        .toString(),
                                    height: myHeight * 0.06,
                                  ),
                                ],
                              ),
                              Text(
                                widget.weatherModel[index].name.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> weather_state = [
    "Rainny",
    "Rainny",
    "Rainny",
    "Cloudy",
    "Sunny",
    "Sunny",
  ];
}
