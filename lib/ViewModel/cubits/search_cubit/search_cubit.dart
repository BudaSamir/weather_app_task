import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/forecast_weather_model.dart';
import '../../database/network/dio_exceptions.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/end_points.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context, listen: false);

  TextEditingController? controller = TextEditingController();
  List<ForecastWeather> searchList = [];

  clearList() {
    searchList.clear();
  }

  Future<void> getForecastWeather(String? cityName) async {
    emit(SearchLoadingState());
    await DioHelper()
        .getData(
            url:
                '$hourlyForecast?key=$apiKey&q=$cityName&days=6&aqi=no&alerts=no')
        .then((response) {
      ForecastWeather forecastWeather = ForecastWeather.fromJson(response.data);
      searchList.add(forecastWeather);
      emit(SearchLoadedState(searchList));
    }).catchError((onError) {
      if (onError is DioException) {
        final errorMessage = DioExceptions.fromDioException(onError).toString();
        emit(SearchFailedState(errorMessage));
      }
    });
  }
}
