part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class LoadingCurrentWeather extends WeatherState {}

class LoadedCurrentWeather extends WeatherState {
  final CurrentWeather currentWeather;

  LoadedCurrentWeather(this.currentWeather);
}

class ErrorCurrentWeather extends WeatherState {
  final String errorMessage;

  ErrorCurrentWeather(this.errorMessage);
}

class LoadingForecastWeather extends WeatherState {}

class LoadedForecastWeather extends WeatherState {
  final HourlyForecast hourlyForecast;

  LoadedForecastWeather(this.hourlyForecast);
}

class ErrorForecastWeather extends WeatherState {
  final String errorMessage;

  ErrorForecastWeather(this.errorMessage);
}

class FindLocation extends WeatherState {}
