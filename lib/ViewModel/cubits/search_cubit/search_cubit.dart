import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/forecast_weather_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context, listen: true);

  TextEditingController? controller = TextEditingController();
  List<ForecastWeather> searchList = [];

  addList(ForecastWeather forecastWeather) {
    searchList.add(forecastWeather);
  }

  clearList() {
    searchList.clear();
  }
}
