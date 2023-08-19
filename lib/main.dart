import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loudweather/ViewModel/database/local/cache_helper.dart';
import 'package:loudweather/ViewModel/database/network/dio_helper.dart';

import 'ViewModel/cubits/weather_cubit/weather_cubit.dart';
import 'loudweather.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await DioHelper.init();
  await CacheHelper().init();
  WeatherCubit().getCurrentWeather('london');
  runApp(const LoudWeather());
}
