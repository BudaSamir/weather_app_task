import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loudweather/Models/hourly_forecast-model.dart';
import 'package:loudweather/ViewModel/database/network/dio_exceptions.dart';
import 'package:loudweather/ViewModel/database/network/dio_helper.dart';
import 'package:meta/meta.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../Models/current_weather_model.dart';
import '../../database/network/end_points.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of(context);

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  LocationPermission? permission;
  Position? position;
  List<Placemark>? placeMarks;
  String? cityName;

  Future<Position> getLatAndLong() async {
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  Future getPotion() async {
    // Check if The location Service is Enabled or not
    bool location = await Geolocator.isLocationServiceEnabled();
    // IF THe location Turned off
    if (location == false) {
      // check Permission For make Location Enable
      permission = await Geolocator.checkPermission();
      // checkPermission Cases
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        // IF User Choose Allow
        if (permission != LocationPermission.denied) {
          position = await getLatAndLong();
          print(position?.latitude);
          print(position?.longitude);
          placeMarks = await placemarkFromCoordinates(
              position!.latitude, position!.latitude);
          print(placeMarks?[0].country);
        }
      } else {
        // IF User Choosed Allow
        position = await getLatAndLong();
        print(position?.latitude);
        print(position?.longitude);
        placeMarks = await placemarkFromCoordinates(
            position!.latitude, position!.latitude);
        print(placeMarks?[0].country);
      }
    } else {
      // IF THe location Turned on
      permission = await Geolocator.requestPermission();
      // IF User Choose Allow
      if (permission != LocationPermission.denied) {
        position = await getLatAndLong();
        print(position?.latitude);
        print(position?.longitude);
        placeMarks = await placemarkFromCoordinates(
            position!.latitude, position!.latitude);
        print(placeMarks?[0].country);
      }
    }
    getCityName();
  }

  getCityName() {
    cityName = placeMarks![0].country!;
    emit(FindLocation());
  }

  String weatherImage(String weatherMain) {
    if (weatherMain == 'Thunderstorm') {
      return 'assets/img/thunderstorm.png';
    } else if (weatherMain == 'Drizzle') {
      return 'assets/img/drizzle.png';
    } else if (weatherMain == 'Rain') {
      return 'assets/img/rains.png';
    } else if (weatherMain == 'Snow') {
      return 'assets/img/snow.png';
    } else if (weatherMain == 'Clear') {
      return 'assets/img/clear.png';
    } else if (weatherMain == 'Clouds') {
      return 'assets/img/clouds.png';
    }
    return '';
  }

  Future<void> getCurrentWeather() async {
    emit(LoadingCurrentWeather());
    await DioHelper()
        .getData(url: '$currentWeather?q=egypt&appid=$apiKey')
        .then((response) {
      CurrentWeather currentWeather = CurrentWeather.fromJson(response.data);
      print('LoadedCurrentWeather');
      print(currentWeather.weather[0].main);
      print(currentWeather.main.temp);
      emit(LoadedCurrentWeather(currentWeather));
    }).catchError((onError) {
      if (onError is DioException) {
        final errorMessage = DioExceptions.fromDioException(onError).toString();
        print(errorMessage);
        emit(ErrorCurrentWeather(errorMessage));
      }
      print(onError);
    });
  }

  Future<void> getForecastWeather() async {
    emit(LoadingForecastWeather());
    await DioHelper()
        .getData(url: '$hourlyForecast?q=London&appid=$apiKey')
        .then((response) {
      HourlyForecast hourlyForecast = HourlyForecast.fromJson(response.data);
      print('LoadingForecastWeather');
      print(hourlyForecast.data[0].dtTxt);
      emit(LoadedForecastWeather(hourlyForecast));
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
