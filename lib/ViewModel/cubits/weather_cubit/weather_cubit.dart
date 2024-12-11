import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../Models/forecast_weather_model.dart';
import '../../../ViewModel/database/network/dio_exceptions.dart';
import '../../../ViewModel/database/network/dio_helper.dart';
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
    print("weatherMain $weatherMain");
    if (weatherMain == 'thunderstorm' ||
        weatherMain == 'patchy light rain with thunder' ||
        weatherMain == 'moderate or heavy rain with thunder' ||
        weatherMain == 'patchy light snow with thunder' ||
        weatherMain == 'moderate or heavy snow with thunder') {
      return 'assets/img/thunderstorm.png';
    } else if (weatherMain == 'drizzle' ||
        weatherMain == 'patchy freezing drizzle possible' ||
        weatherMain == 'mist') {
      return 'assets/img/drizzle.png';
    } else if (weatherMain == 'rain' ||
        weatherMain == 'heavy rain' ||
        weatherMain == 'moderate rain' ||
        weatherMain == 'patchy rain possible') {
      return 'assets/img/rains.png';
    } else if (weatherMain == 'snow' ||
        weatherMain == 'patchy snow possible' ||
        weatherMain == 'blowing snow') {
      return 'assets/img/snow.png';
    } else if (weatherMain == 'clear' || weatherMain == 'sunny') {
      return 'assets/img/clear.png';
    } else if (weatherMain == 'overcast' ||
        weatherMain == 'partly cloudy' ||
        weatherMain == 'cloudy') {
      return 'assets/img/clouds.png';
    }
    return '';
  }

  Future<void> getForecastWeather(String? cityName) async {
    String name;
    if (cityName == null || cityName.trim() == "") {
      name = 'cairo';
    } else {
      name = cityName;
    }
    emit(LoadingForecastWeather());
    await DioHelper()
        .getData(
            url: '$hourlyForecast?key=$apiKey&q=cairo&days=6&aqi=no&alerts=no')
        .then((response) {
      ForecastWeather forecastWeather = ForecastWeather.fromJson(response.data);
      emit(LoadedForecastWeather(forecastWeather));
    }).catchError((onError, stacktrace) {
      if (onError is DioException) {
        final errorMessage = DioExceptions.fromDioException(onError).toString();
        // print(errorMessage);
        emit(ErrorForecastWeather(errorMessage));
      }
      print(onError);
      print(stacktrace);
    });
  }
}
