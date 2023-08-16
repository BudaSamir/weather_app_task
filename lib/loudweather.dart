import 'package:flutter/material.dart';
import 'package:loudweather/View/Screens/splash_screen.dart';

class LoudWeather extends StatelessWidget {
  const LoudWeather({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loud Weather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
