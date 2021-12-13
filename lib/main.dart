import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cubit/data/repository/network_service.dart';
import 'package:weather_app_cubit/data/repository/weather_repository.dart';
import 'package:weather_app_cubit/pages/weather_search_page.dart';
import 'cubit/weather_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (context) =>
          WeatherCubit(WeatherRepository(networkService: NetworkService())),
      child: const WeatherSearchPage(),
    ));
  }
}
