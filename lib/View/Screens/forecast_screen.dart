import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loudweather/View/components/home_screen/hourly_weather_section.dart';

import '../../Core/Utils/global_methods.dart';
import '../../ViewModel/cubits/weather_cubit/weather_cubit.dart';
import '../Widgets/item.dart';

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
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff060720),
      appBar: AppBar(
        backgroundColor: const Color(0xff060720),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Forecast Report',
          style: GoogleFonts.poppins(
              fontSize: 22.5, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child:
            BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
          if (state is LoadedForecastWeather) {
            return Column(children: [
              SizedBox(height: myHeight * 0.015),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.04),
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
                    Text(
                      GlobalMethods.formattedDateText(
                          state.forecastWeather.current.lastUpdated, true),
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.white.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: myHeight * 0.025),
              HourlyWeatherSection(forecastWeather: state.forecastWeather),
              SizedBox(height: myHeight * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: myWidth * 0.04, vertical: myHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Forecast Report',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w500),
                    ),
                    Image.asset('assets/icons/5.png',
                        height: myHeight * 0.03,
                        color: Colors.white.withOpacity(0.5)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount:
                        state.forecastWeather.forecast.forecastDay.length,
                    itemBuilder: (context, index) {
                      return Item(
                        day: state.forecastWeather.forecast.forecastDay[index],
                      );
                    }),
              ),
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    ));
  }
}
