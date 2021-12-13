import 'package:flutter/material.dart';
import 'package:weather_app_cubit/data/model/weather.dart';

class WeatherDetail extends StatelessWidget {
  Weather weatherData;
  WeatherDetail(this.weatherData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Weather report"),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    'https://openweathermap.org/img/w/${weatherData.icon.toString()}.png',
                  ),
                  getCardWidget('CityName : ${weatherData.cityName}'),
                  getCardWidget(
                      'Temperature : ${weatherData.temperature.toString()}'),
                  getCardWidget('Description : ${weatherData.description}'),
                  getCardWidget(
                      'Sunrise Time : ${weatherData.sunRiseTime.toString()}'),
                  getCardWidget(
                      'Sunset Time : ${weatherData.sunSetTime.toString()}')
                ]),
          ),
        ),
      ),
    );
  }

  Widget getCardWidget(String value) {
    return Card(
      color: Colors.white54,
      elevation: 5,
      child: Text(
        value,
        style: const TextStyle(fontSize: 25),
      ),
    );
  }
}
