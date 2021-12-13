import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_cubit/data/model/weather.dart';
import 'package:weather_app_cubit/data/repository/weather_repository.dart';
part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(const WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(const WeatherLoading());
      final weather = await _weatherRepository.fetchWeatherData(cityName);
      emit(WeatherLoaded(weather: weather));
    } on Exception catch (e) {
      emit(WeatherError(message: e.toString()));
    }
  }
}
