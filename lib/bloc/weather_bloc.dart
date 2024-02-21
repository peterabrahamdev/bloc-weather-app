import 'package:bloc_weather_app/data/repository/weather_repository.dart';
import 'package:bloc_weather_app/models/weather_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // Creating a separate parameter to be able to unit test this class.
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherEvent>(_getCurrentWeather);
  }

  void _getCurrentWeather(
      WeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoading());
      final weather = await weatherRepository.getCurrentWeather();
      emit(WeatherSuccess(weatherModel: weather));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }
}
