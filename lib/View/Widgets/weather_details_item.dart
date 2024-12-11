import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/weather_details_model.dart';

class WeatherDetailsItem extends StatelessWidget {
  final WeatherDetails weatherDetails;

  const WeatherDetailsItem({
    super.key,
    required this.weatherDetails,
  });

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidth * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              height: myHeight * 0.06,
              width: myWidth * 0.06,
              child: Image.asset(weatherDetails.img, fit: BoxFit.contain)),
          Text(
            weatherDetails.label,
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
          ),
          Text(
            weatherDetails.title,
            style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
