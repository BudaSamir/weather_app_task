// class CurrentWeather {
//   final Coord coord;
//   final List<Weather> weather;
//   final String base;
//   final Main main;
//   final int visibility;
//   final Wind wind;
//   final Clouds clouds;
//   final int dt;
//   final Sys sys;
//   final int timezone;
//   final int id;
//   final String name;
//   final int cod;
//
//   const CurrentWeather({
//     required this.coord,
//     required this.weather,
//     required this.base,
//     required this.main,
//     required this.visibility,
//     required this.wind,
//     required this.clouds,
//     required this.dt,
//     required this.sys,
//     required this.timezone,
//     required this.id,
//     required this.name,
//     required this.cod,
//   });
//
//   factory CurrentWeather.fromJson(Map<String, dynamic> json) {
//     List<Weather> weatherList = [];
//     for (var element in (json['weather'])) {
//       weatherList.add(Weather.fromJson(element));
//     }
//     return CurrentWeather(
//       coord: Coord.fromJson(json['coord']),
//       weather: weatherList,
//       base: json['base'],
//       main: Main.fromJson(json['main']),
//       visibility: json['visibility'],
//       wind: Wind.fromJson(json['wind']),
//       clouds: Clouds.fromJson(json['clouds']),
//       dt: json['dt'],
//       sys: Sys.fromJson(json['sys']),
//       timezone: json['timezone'],
//       id: json['id'],
//       name: json['name'],
//       cod: json['cod'],
//     );
//   }
// }
//
// class Coord {
//   final double lon;
//   final double lat;
//
//   const Coord({
//     required this.lon,
//     required this.lat,
//   });
//
//   factory Coord.fromJson(Map<String, dynamic> json) {
//     return Coord(lon: json['lon'], lat: json['lat']);
//   }
// }
//
// class Weather {
//   final int id;
//   final String main;
//   final String description;
//   final String icon;
//
//   const Weather({
//     required this.id,
//     required this.main,
//     required this.description,
//     required this.icon,
//   });
//
//   factory Weather.fromJson(Map<String, dynamic> json) {
//     return Weather(
//         id: json['id'],
//         main: json['main'],
//         description: json['description'],
//         icon: json['icon']);
//   }
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['main'] = main;
//     data['description'] = description;
//     data['icon'] = icon;
//     return data;
//   }
// }
//
// class Main {
//   final double temp;
//   final double feelsLike;
//   final double tempMin;
//   final double tempMax;
//   final int pressure;
//   final int humidity;
//
//   const Main({
//     required this.temp,
//     required this.feelsLike,
//     required this.tempMin,
//     required this.tempMax,
//     required this.pressure,
//     required this.humidity,
//   });
//
//   factory Main.fromJson(Map<String, dynamic> json) {
//     return Main(
//         temp: json['temp'],
//         feelsLike: json['feels_like'],
//         tempMin: json['temp_min'],
//         tempMax: json['temp_max'],
//         pressure: json['pressure'],
//         humidity: json['humidity']);
//   }
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = {};
//     data['temp'] = temp;
//     data['feels_like'] = feelsLike;
//     data['temp_min'] = tempMin;
//     data['temp_max'] = tempMax;
//     data['pressure'] = pressure;
//     data['humidity'] = humidity;
//     return data;
//   }
// }
//
// class Wind {
//   final double speed;
//   final int deg;
//   const Wind({required this.speed, required this.deg});
//
//   factory Wind.fromJson(Map<String, dynamic> json) {
//     return Wind(speed: json['speed'], deg: json['deg']);
//   }
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = {};
//     data['speed'] = speed;
//     data['deg'] = deg;
//     return data;
//   }
// }
//
// class Clouds {
//   final int all;
//
//   const Clouds({required this.all});
//
//   factory Clouds.fromJson(Map<String, dynamic> json) {
//     return Clouds(all: json['all']);
//   }
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = {};
//     data['all'] = all;
//     return data;
//   }
// }
//
// class Sys {
//   final int type;
//   final int id;
//   final String country;
//   final int sunrise;
//   final int sunset;
//
//   const Sys(
//       {required this.sunrise,
//       required this.sunset,
//       required this.type,
//       required this.id,
//       required this.country});
//
//   factory Sys.fromJson(Map<String, dynamic> json) {
//     return Sys(
//       type: json['type'],
//       id: json['id'],
//       country: json['country'],
//       sunrise: json['sunrise'],
//       sunset: json['sunset'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['type'] = type;
//     data['id'] = id;
//     data['country'] = country;
//     data['sunrise'] = sunrise;
//     data['sunset'] = sunset;
//     return data;
//   }
// }
class CurrentWeather {
  final WeatherLocation weatherLocation;
  final Current current;

  const CurrentWeather({required this.weatherLocation, required this.current});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      weatherLocation: WeatherLocation.fromJson(json['location']),
      current: Current.formJson(json['current']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['location'] = weatherLocation.toJson();
    data['current'] = current.toJson();
    return data;
  }
}

class WeatherLocation {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  const WeatherLocation({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    return WeatherLocation(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
      tzId: json['tz_id'],
      localtimeEpoch: json['localtime_epoch'],
      localtime: json['localtime'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['region'] = region;
    data['country'] = country;
    data['lat'] = lat;
    data['lon'] = lon;
    data['tz_id'] = tzId;
    data['localtime_epoch'] = localtimeEpoch;
    data['localtime'] = localtime;
    return data;
  }
}

class Current {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final int isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;

  const Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
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
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory Current.formJson(Map<String, dynamic> json) {
    return Current(
      lastUpdatedEpoch: json['last_updated_epoch'],
      lastUpdated: json['last_updated'],
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
      visKm: json['vis_km'],
      visMiles: json['vis_miles'],
      uv: json['uv'],
      gustMph: json['gust_mph'],
      gustKph: json['gust_kph'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['last_updated_epoch'] = lastUpdatedEpoch;
    data['last_updated'] = lastUpdated;
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
    data['vis_km'] = visKm;
    data['vis_miles'] = visMiles;
    data['uv'] = uv;
    data['gust_mph'] = gustMph;
    data['gust_kph'] = gustKph;
    return data;
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  const Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['text'] = text;
    data['icon'] = icon;
    data['code'] = code;
    return data;
  }
}
