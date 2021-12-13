import 'package:weather_app_cubit/data/model/weather.dart';
import 'package:weather_app_cubit/data/repository/network_service.dart';

class WeatherRepository {
  final NetworkService networkService;
  WeatherRepository({required this.networkService});

  Future<Weather> fetchWeatherData(String cityName) async {
    final jsonData = await networkService.fetchWeatherData(cityName);
    Weather weatherModel = Weather.fromJson(jsonData);
    return weatherModel;
  }
}
