import 'current_weather_model.dart';
//
// class HourlyForecast {
//   final String code;
//   final int message;
//   final int cnt;
//   final List<ForecastData> data;
//   const HourlyForecast({
//     required   this.code,
//     required   this.message,
//     required   this.cnt,
//     required   this.data,
//   });
//
//   factory HourlyForecast.fromJson(Map<String, dynamic> json) {
//     List<ForecastData> dataList = [];
//     for (var element in json['list']) {
//       dataList.add(ForecastData.fromJson(element));
//     }
//     return HourlyForecast(
//       code: json['cod'],
//       message: json['message'],
//       cnt: json['cnt'],
//       data: dataList,
//     );
//   }
// }
//
// class ForecastData {
//   final int dt;
//   final Main main;
//   final List<Weather> weather;
//   final Clouds clouds;
//   final Wind wind;
//   final int visibility;
//   final int pop;
//   final Sys  sys;
//   final String  dtTxt;
//
//   const ForecastData({
//     required   this.dt,
//     required   this.main,
//     required   this.weather,
//     required   this.clouds,
//     required   this.wind,
//     required   this.visibility,
//     required   this.pop,
//     required   this.sys,
//     required   this.dtTxt,
//   });
//
//   factory ForecastData.fromJson(Map<String, dynamic> json) {
//     List<Weather> weatherList = [];
//     for (var element in json['weather']) {
//       weatherList.add(Weather.fromJson(element));
//     }
//     return ForecastData(
//       dt: json['dt'],
//       main: Main.fromJson(json['main']),
//       weather: weatherList,
//       clouds: Clouds.fromJson(json['clouds']),
//       wind: Wind.fromJson(json['wind']),
//       visibility: json['visibility']    0,
//       pop: json['pop']    0,
//       sys: Sys.fromJson(json['sys']),
//       dtTxt: json['dt_txt'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = {};
//     data['dt'] = dt;
//     data['main'] = main;
//     data['weather'] = weather;
//     data['clouds'] = clouds;
//     data['wind'] = wind;
//     data['visibility'] = visibility;
//     data['pop'] = pop;
//     data['sys'] = sys;
//     data['dt_txt'] = dt;
//     return data;
//   }
// }

class ForecastWeather {
  final WeatherLocation weatherLocation;
  final Current current;
  final Forecast forecast;

  const ForecastWeather({
    required this.forecast,
    required this.weatherLocation,
    required this.current,
  });

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
        weatherLocation: WeatherLocation.fromJson(json['location']),
        current: Current.formJson(json['current']),
        forecast: Forecast.fromJson(json['forecast']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['location'] = weatherLocation.toJson();
    data['current'] = current.toJson();
    return data;
  }
}

class Forecast {
  final List<ForecastDay> forecastDay;

  const Forecast({required this.forecastDay});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    List<ForecastDay> forecastDayList = [];
    for (var element in json['forecastday']) {
      forecastDayList.add(ForecastDay.fromJson(element));
    }
    return Forecast(forecastDay: forecastDayList);
  }
}

class ForecastDay {
  final String date;
  final int dateEpoch;
  final Day day;
  final Astro astro;
  final List<Hour> hour;

  const ForecastDay({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    List<Hour> hourList = [];
    for (var element in json['hour']) {
      hourList.add(Hour.fromJson(element));
    }
    return ForecastDay(
      date: json['date'],
      dateEpoch: json['date_epoch'],
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
      hour: hourList,
    );
  }
}

class Day {
  final double maxtempC;
  final double maxtempF;
  final double mintempC;
  final double mintempF;
  final double avgtempC;
  final double avgtempF;
  final int maxwindMph;
  final double maxwindKph;
  final int totalprecipMm;
  final int totalprecipIn;
  final int totalsnowCm;
  final int avgvisKm;
  final int avgvisMiles;
  final int avghumidity;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final Condition condition;
  final int uv;

  const Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.totalprecipIn,
    required this.totalsnowCm,
    required this.avgvisKm,
    required this.avgvisMiles,
    required this.avghumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c'],
      maxtempF: json['maxtemp_f'],
      mintempC: json['mintemp_c'],
      mintempF: json['mintemp_f'],
      avgtempC: json['avgtemp_c'],
      avgtempF: json['avgtemp_f'],
      maxwindMph: json['maxwind_mph'],
      maxwindKph: json['maxwind_kph'],
      totalprecipMm: json['totalprecip_mm'],
      totalprecipIn: json['totalprecip_in'],
      totalsnowCm: json['totalsnow_cm'],
      avgvisKm: json['avgvis_km'],
      avgvisMiles: json['avgvis_miles'],
      avghumidity: json['avghumidity'],
      dailyWillItRain: json['daily_will_it_rain'],
      dailyChanceOfRain: json['daily_chance_of_rain'],
      dailyWillItSnow: json['daily_will_it_snow'],
      dailyChanceOfSnow: json['daily_chance_of_snow'],
      condition: Condition.fromJson(json['maxtemp_c']),
      uv: json['uv'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['maxtemp_c'] = maxtempC;
    data['maxtemp_f'] = maxtempF;
    data['mintemp_c'] = mintempC;
    data['mintemp_f'] = mintempF;
    data['avgtemp_c'] = avgtempC;
    data['avgtemp_f'] = avgtempF;
    data['maxwind_mph'] = maxwindMph;
    data['maxwind_kph'] = maxwindKph;
    data['totalprecip_mm'] = totalprecipMm;
    data['totalprecip_in'] = totalprecipIn;
    data['totalsnow_cm'] = totalsnowCm;
    data['avgvis_km'] = avgvisKm;
    data['avgvis_miles'] = avgvisMiles;
    data['avghumidity'] = avghumidity;
    data['daily_will_it_rain'] = dailyWillItRain;
    data['daily_chance_of_rain'] = dailyChanceOfRain;
    data['daily_will_it_snow'] = dailyWillItSnow;
    data['daily_chance_of_snow'] = dailyChanceOfSnow;
    data['condition'] = condition.toJson();
    data['uv'] = uv;
    return data;
  }
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final String moonIllumination;
  final int isMoonUp;
  final int isSunUp;

  const Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
    required this.isMoonUp,
    required this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: json['moon_phase'],
      moonIllumination: json['moon_illumination'],
      isMoonUp: json['is_moon_up'],
      isSunUp: json['is_sun_up'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['moonrise'] = moonrise;
    data['moonset'] = moonset;
    data['moon_phase'] = moonPhase;
    data['moon_illumination'] = moonIllumination;
    data['is_moon_up'] = isMoonUp;
    data['is_sun_up'] = isSunUp;
    return data;
  }
}

class Hour {
  final int timeEpoch;
  final String time;
  final double tempC;
  final double tempF;
  final int isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final int pressureMb;
  final double pressureIn;
  final int precipMm;
  final int precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double windchillC;
  final double windchillF;
  final double heatindexC;
  final double heatindexF;
  final double dewpointC;
  final double dewpointF;
  final int willItRain;
  final int chanceOfRain;
  final int willItSnow;
  final int chanceOfSnow;
  final int visKm;
  final int visMiles;
  final double gustMph;
  final double gustKph;
  final int uv;

  const Hour({
    required this.timeEpoch,
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.willItRain,
    required this.chanceOfRain,
    required this.willItSnow,
    required this.chanceOfSnow,
    required this.visKm,
    required this.visMiles,
    required this.gustMph,
    required this.gustKph,
    required this.uv,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      timeEpoch: json['time_epoch'],
      time: json['time'],
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      windMph: json['wind_mph'],
      windKph: json['wind_kph'],
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'],
      pressureIn: json['pressure_in'],
      precipMm: json['precip_mm'],
      precipIn: json['precip_in'],
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'],
      feelslikeF: json['feelslike_f'],
      windchillC: json['windchill_c'],
      windchillF: json['windchill_f'],
      heatindexC: json['heatindex_c'],
      heatindexF: json['heatindex_f'],
      dewpointC: json['dewpoint_c'],
      dewpointF: json['dewpoint_f'],
      willItRain: json['will_it_rain'],
      chanceOfRain: json['chance_of_rain'],
      willItSnow: json['will_it_snow'],
      chanceOfSnow: json['chance_of_snow'],
      visKm: json['vis_km'],
      visMiles: json['vis_miles'],
      gustMph: json['gust_mph'],
      gustKph: json['gust_kph'],
      uv: json['uv'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['time_epoch'] = timeEpoch;
    data['time'] = time;
    data['temp_c'] = tempC;
    data['temp_f'] = tempF;
    data['is_day'] = isDay;
    data['condition'] = condition.toJson();
    data['wind_mph'] = windMph;
    data['wind_kph'] = windKph;
    data['wind_degree'] = windDegree;
    data['wind_dir'] = windDir;
    data['pressure_mb'] = pressureMb;
    data['pressure_in'] = pressureIn;
    data['precip_mm'] = precipMm;
    data['precip_in'] = precipIn;
    data['humidity'] = humidity;
    data['cloud'] = cloud;
    data['feelslike_c'] = feelslikeC;
    data['feelslike_f'] = feelslikeF;
    data['windchill_c'] = windchillC;
    data['windchill_f'] = windchillF;
    data['heatindex_c'] = heatindexC;
    data['heatindex_f'] = heatindexF;
    data['dewpoint_c'] = dewpointC;
    data['dewpoint_f'] = dewpointF;
    data['will_it_rain'] = willItRain;
    data['chance_of_rain'] = chanceOfRain;
    data['will_it_snow'] = willItSnow;
    data['chance_of_snow'] = chanceOfSnow;
    data['vis_km'] = visKm;
    data['vis_miles'] = visMiles;
    data['gust_mph'] = gustMph;
    data['gust_kph'] = gustKph;
    data['uv'] = uv;
    return data;
  }
}
