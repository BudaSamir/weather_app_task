import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loudweather/Core/Utils/global_methods.dart';
import 'package:loudweather/View/Screens/search_screen.dart';

import '../../../Models/hourly_forecast-model.dart';
import '../../../Models/weather_details_model.dart';
import '../../../ViewModel/cubits/weather_cubit/weather_cubit.dart';
import '../../Widgets/weather_details_item.dart';

class CurrentWeatherSection extends StatelessWidget {
  final ForecastWeather forecastWeather;
  const CurrentWeatherSection({Key? key, required this.forecastWeather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    var weatherCubit = WeatherCubit.get(context);
    return Container(
      height: myHeight * 0.69,
      width: myWidth,
      // padding: EdgeInsets.symmetric(horizontal: myWidth * 0.07),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(60)),
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
            children: [
              Padding(
                padding: EdgeInsets.only(left: myWidth * 0.04),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ));
                  },
                  child: Image.asset(
                    'assets/icons/2.2.png',
                    height: myHeight * 0.04,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: myWidth * 0.23),
              Image.asset(
                'assets/icons/6.png',
                height: myHeight * 0.033,
                color: Colors.white,
              ),
              Text(
                forecastWeather.weatherLocation.name,
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 100,
                  spreadRadius: -60,
                  offset: const Offset(20, 0))
            ]),
            child: Image.asset(
              weatherCubit.weatherImage(forecastWeather.current.condition.text),
              height: myHeight * 0.25,
              width: myWidth * 0.7,
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    forecastWeather.current.tempC.toInt().toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 60,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    '°C \n ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                forecastWeather.current.condition.text,
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Text(
            '${DateFormat('EEEE').format(DateTime.parse(forecastWeather.current.lastUpdated))} \t ${GlobalMethods.formattedDateText(forecastWeather.current.lastUpdated, true)}',
            style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: myWidth * 0.01),
            child: Divider(
              color: Colors.white.withOpacity(0.15),
              indent: 30,
              endIndent: 30,
            ),
          ),
          SizedBox(
              height: myHeight * 0.13,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                padding: EdgeInsets.only(left: myWidth * 0.07),
                itemBuilder: (context, index) {
                  List detailsList = weatherDetailsList(forecastWeather);
                  return WeatherDetailsItem(
                    weatherDetails: detailsList[index],
                  );
                },
              )),
        ],
      ),
    );
  }
}
