import 'package:intl/intl.dart';

class Weather {
  String cityName;
  double temperature;
  String description;
  String sunRiseTime;
  String sunSetTime;
  String icon;
  Weather(
      {required this.cityName,
      required this.temperature,
      required this.description,
      required this.sunRiseTime,
      required this.sunSetTime,
      required this.icon});

  factory Weather.fromJson(Map weatherMap) {
    Map tempData = weatherMap['main'];
    double temperature = double.parse(tempData['temp'].toString());
    var weatherData = weatherMap['weather'];
    String description = weatherData[0]['description'];
    String icon = weatherData[0]['icon'];
    Map sunriseSunset = weatherMap['sys'];
    String sunriseTime = Weather.getSunriseLocalTime(sunriseSunset);
    String sunsetTime = Weather.getSunsetLocalTime(sunriseSunset);
    String cityName = weatherMap['name'];

    return Weather(
        cityName: cityName,
        temperature: temperature,
        description: description,
        sunRiseTime: sunriseTime,
        sunSetTime: sunsetTime,
        icon: icon);
  }

  static String getSunriseLocalTime(Map sunriseSunset) {
    var sunRise = sunriseSunset['sunrise'];
    DateTime riseDatetime =
        DateTime.fromMillisecondsSinceEpoch(sunRise * 1000, isUtc: true)
            .toLocal();
    return DateFormat().add_jm().format(riseDatetime);
  }

  static String getSunsetLocalTime(Map sunriseSunset) {
    var sunSet = sunriseSunset['sunset'];
    DateTime setDatetime =
        DateTime.fromMillisecondsSinceEpoch(sunSet * 1000, isUtc: true)
            .toLocal();
    return DateFormat().add_jm().format(setDatetime);
  }
}
