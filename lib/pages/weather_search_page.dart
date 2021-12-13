import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cubit/cubit/weather_cubit.dart';
import 'package:weather_app_cubit/pages/weather_detail.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Weather search"),
        leading: const Icon(
          Icons.cloud,
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child:
              BlocConsumer<WeatherCubit, WeatherState>(listener: (ctx, state) {
            if (state is WeatherLoaded) {
              Navigator.push(
                  ctx,
                  MaterialPageRoute(
                      builder: (ctx) => WeatherDetail(state.weather)));
            } else if (state is WeatherError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          }, builder: (ctx, state) {
            if (state is WeatherInitial) {
              return buildInitialInput();
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else {
              return buildInitialInput();
            }
          })),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: cityInputField(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget cityInputField() {
    final cityController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Card(
                  elevation: 5,
                  child: TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      hintText: 'Enter city name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                          color: Colors.indigo,
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    style: const TextStyle(fontSize: 20),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      searchWeatherByCity(context, value);
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  searchWeatherByCity(context, cityController.text);
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }

  void searchWeatherByCity(BuildContext ctx, String cityName) {
    if (cityName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter city name'),
        ),
      );
      return;
    }
    BlocProvider.of<WeatherCubit>(ctx).getWeather(cityName);
  }
}
