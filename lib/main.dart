import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loudweather/ViewModel/database/local/cache_helper.dart';
import 'package:loudweather/ViewModel/database/network/dio_helper.dart';

import 'loudweather.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await DioHelper.init();
  await CacheHelper().init();
  runApp(const LoudWeather());
}
