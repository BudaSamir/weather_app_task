part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  List<ForecastWeather> searchList;

  SearchLoadedState(this.searchList);
}

class SearchFailedState extends SearchState {
  SearchFailedState(String errorMessage);
}
