import 'current_weather_model.dart';

class HourlyForecast {
  final String code;
  final int message;
  final int cnt;
  final List<ForecastData> data;
  const HourlyForecast({
    required this.code,
    required this.message,
    required this.cnt,
    required this.data,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    List<ForecastData> dataList = [];
    for (var element in json['list']) {
      dataList.add(ForecastData.fromJson(element));
    }
    return HourlyForecast(
      code: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      data: dataList,
    );
  }
}

class ForecastData {
  final int dt;
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double? pop;
  final Sys? sys;
  final String? dtTxt;

  const ForecastData({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List<Weather> weatherList = [];
    for (var element in json['weather']) {
      weatherList.add(Weather.fromJson(element));
    }
    return ForecastData(
      dt: json['dt'],
      main: Main.fromJson(json['main']),
      weather: weatherList,
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'],
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['dt'] = dt;
    data['main'] = main;
    data['weather'] = weather;
    data['clouds'] = clouds;
    data['wind'] = wind;
    data['visibility'] = visibility;
    data['pop'] = pop;
    data['sys'] = sys;
    data['dt_txt'] = dt;
    return data;
  }
}
