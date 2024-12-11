import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../View/components/home_screen/hourly_weather_section.dart';
import '../../ViewModel/cubits/home_screen_cubit/home_screen_cubit.dart';
import '../../ViewModel/cubits/search_cubit/search_cubit.dart';
import '../../ViewModel/cubits/weather_cubit/weather_cubit.dart';
import '../components/home_screen/current_weather_section.dart';
import 'forecast_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    var weatherCubit = WeatherCubit.get(context);
    var homeScreenCubit = HomeScreenCubit.get(context);
    final searchCubit = SearchCubit.get(context);
    weatherCubit.getForecastWeather(
        homeScreenCubit.placeMarks?[0].country?.trim().toLowerCase());
    return Scaffold(
      backgroundColor: const Color(0xff060720),
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is LoadedForecastWeather) {
              return Column(
                children: [
                  CurrentWeatherSection(forecastWeather: state.forecastWeather),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: myWidth * 0.03, vertical: myHeight * 0.015),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForecastScreen(),
                                ));
                          },
                          child: Text(
                            'View Full Report',
                            style: GoogleFonts.poppins(
                                fontSize: 15, color: const Color(0xff3fa2fa)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  HourlyWeatherSection(forecastWeather: state.forecastWeather),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
