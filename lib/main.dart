import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './ViewModel/database/local/cache_helper.dart';
import './ViewModel/database/network/dio_helper.dart';
import 'weather_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await DioHelper.init();
  await CacheHelper().init();
  runApp(const WeatherApp());
}
