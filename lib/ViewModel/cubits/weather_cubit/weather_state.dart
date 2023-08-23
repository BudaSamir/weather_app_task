part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class LoadingForecastWeather extends WeatherState {}

class LoadedForecastWeather extends WeatherState {
  final ForecastWeather forecastWeather;

  LoadedForecastWeather(this.forecastWeather);
}

class ErrorForecastWeather extends WeatherState {
  final String errorMessage;

  ErrorForecastWeather(this.errorMessage);
}
