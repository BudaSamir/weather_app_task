import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loudweather/ViewModel/cubits/search_cubit/search_cubit.dart';
import 'package:loudweather/ViewModel/cubits/weather_cubit/weather_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final searchCubit = SearchCubit.get(context);
    final weatherCubit = WeatherCubit.get(context);
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
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                              controller: searchCubit.controller,
                              cursorColor: Colors.white.withOpacity(0.5),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Image.asset(
                                    'assets/icons/2.2.png',
                                    height: myHeight * 0.025,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  focusColor: Colors.white.withOpacity(0.5),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5))),
                            ),
                          ),
                        )),
                    SizedBox(width: myWidth * 0.03),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            weatherCubit.getForecastWeather(
                                searchCubit.controller!.text);
                          },
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
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: myHeight * 0.04),
              Expanded(
                child: BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state) {
                    if (state is LoadedForecastWeather) {
                      searchCubit.addList(state.forecastWeather);
                      print(searchCubit.searchList.length);
                      return GridView.custom(
                        padding:
                            EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                        gridDelegate: SliverStairedGridDelegate(
                            mainAxisSpacing: 13,
                            startCrossAxisDirectionReversed: false,
                            pattern: [
                              const StairedGridTile(0.5, 3 / 2.2),
                              const StairedGridTile(0.5, 3 / 2.2),
                            ]),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: searchCubit.searchList.length,
                          (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: myWidth * 0.02),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.white.withOpacity(0.05),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromARGB(255, 21, 85, 169),
                                      Color.fromARGB(255, 44, 162, 246),
                                    ])),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              searchCubit.searchList[index]
                                                  .current.tempC
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              searchCubit.searchList[index]
                                                  .current.condition.text,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white
                                                      .withOpacity(0.5)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: myWidth * 0.02),
                                        Image.asset(
                                          weatherCubit.weatherImage(searchCubit
                                              .searchList[index]
                                              .current
                                              .condition
                                              .text),
                                          height: myHeight * 0.03,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      searchCubit.searchList[index]
                                          .weatherLocation.name,
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
// color: StaticFile.myLocation ==
// widget.weatherModel[index].name
//     .toString()
// ? null
// : Colors.white.withOpacity(0.05),
// gradient: StaticFile.myLocation ==
// widget.weatherModel[index].name
//     .toString()
// ? const LinearGradient(colors: [
// Color.fromARGB(255, 21, 85, 169),
// Color.fromARGB(255, 44, 162, 246),
// ])
// : null),
