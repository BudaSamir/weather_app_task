class WeatherDetails {
  final String img;
  final String label;
  final String title;

  WeatherDetails({required this.img, required this.label, required this.title});
}

List<WeatherDetails> weatherDetailsList(forecastWeather) {
  return [
    WeatherDetails(
        img: 'assets/img/wind.png',
        label: '${forecastWeather.current.windKph.toInt().toString()}%',
        title: 'Wind'),
    WeatherDetails(
        img: 'assets/img/humidity.png',
        label: '${forecastWeather.current.humidity.toString()}%',
        title: 'Humidity'),
    WeatherDetails(
        img: 'assets/img/rain.png',
        label: '${forecastWeather.current.cloud.toString()}%',
        title: 'Rain'),
  ];
}
