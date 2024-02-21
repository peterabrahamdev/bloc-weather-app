// In this class, we are taking the raw data extracted in the WeatherDataProvider
// and converting it to a WeatherModel.

import 'dart:convert';

import 'package:bloc_weather_app/data/data_provider/weather_data_provider.dart';
import 'package:bloc_weather_app/models/weather_model.dart';

class WeatherRepository {
  WeatherRepository(this.weatherDataProvider);
  final WeatherDataProvider weatherDataProvider;

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.fromJson(weatherData);
    } catch (e) {
      throw e.toString();
    }
  }
}
