import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../Models/weather_model.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadJson();
    });
    super.initState();
  }

  List data = [];
  List<WeatherModel> weatherList = [];

  loadJson() async {
    String myData = await rootBundle.loadString('assets/myJson/file.json');

    setState(() {
      data = json.decode(myData);
      weatherList = data.map((e) => WeatherModel.fromJson(e)).toList();
      weatherList = weatherList;
    });
    Timer(
      const Duration(seconds: 2),
      (() => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => HomeScreen(weatherModel: weatherList))))),
    );
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset('assets/img/loading.json'),
              Text('Loud Weather',
                  style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 50,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
