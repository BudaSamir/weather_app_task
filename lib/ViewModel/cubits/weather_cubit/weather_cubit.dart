import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loudweather/Models/forecast_weather_model.dart';
import 'package:loudweather/ViewModel/database/network/dio_exceptions.dart';
import 'package:loudweather/ViewModel/database/network/dio_helper.dart';
import 'package:meta/meta.dart';

import '../../database/network/end_points.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of(context, listen: false);

  DateTime timeNow = DateTime.now();

  bool findTime(String currentTime) {
    final parsedData = DateTime.parse(currentTime);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedData);
    DateTime weatherTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(formattedDate);
    if (weatherTime.hour == timeNow.hour) {
      return true;
    } else {
      return false;
    }
  }

  String weatherImage(String weatherMain) {
    if (weatherMain == 'Thunderstorm' ||
        weatherMain == 'Patchy light rain with thunder' ||
        weatherMain == 'Moderate or heavy rain with thunder' ||
        weatherMain == 'Patchy light snow with thunder' ||
        weatherMain == 'Moderate or heavy snow with thunder') {
      return 'assets/img/thunderstorm.png';
    } else if (weatherMain == 'Drizzle' ||
        weatherMain == 'Patchy freezing drizzle possible' ||
        weatherMain == 'Mist') {
      return 'assets/img/drizzle.png';
    } else if (weatherMain == 'Rain' ||
        weatherMain == 'Heavy rain' ||
        weatherMain == 'Moderate rain' ||
        weatherMain == 'Patchy rain possible') {
      return 'assets/img/rains.png';
    } else if (weatherMain == 'Snow' ||
        weatherMain == 'Patchy snow possible' ||
        weatherMain == 'Blowing snow') {
      return 'assets/img/snow.png';
    } else if (weatherMain == 'Clear' || weatherMain == 'Sunny') {
      return 'assets/img/clear.png';
    } else if (weatherMain == 'Overcast' ||
        weatherMain == 'Partly cloudy' ||
        weatherMain == 'Cloudy') {
      return 'assets/img/clouds.png';
    }
    return '';
  }

  Future<void> getForecastWeather(String? cityName) async {
    String name = cityName ?? 'London';
    emit(LoadingForecastWeather());
    print(cityName);
    await DioHelper()
        .getData(
            url: '$hourlyForecast?key=$apiKey&q=$name&days=6&aqi=no&alerts=no')
        .then((response) {
      ForecastWeather forecastWeather = ForecastWeather.fromJson(response.data);
      emit(LoadedForecastWeather(forecastWeather));
    }).catchError((onError) {
      if (onError is DioException) {
        final errorMessage = DioExceptions.fromDioException(onError).toString();
        print(errorMessage);
        emit(ErrorForecastWeather(errorMessage));
      }
      print(onError);
    });
  }
}
