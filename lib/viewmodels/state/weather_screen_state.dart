import 'package:weatherapp/core/network/response_wrapper.dart';
import 'package:weatherapp/models/weather_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/usecases/weather_usecase.dart';
import 'package:weatherapp/viewmodels/provider/weather_screen_provider.dart';

class WeatherScreenState {
  final bool isLoading;
  final ResponseWrapper<WeatherResponseModel?>? data;

  WeatherScreenState({
    required this.isLoading,
    this.data,
  });

  WeatherScreenState copyWith({
    bool? isLoading,
    ResponseWrapper<WeatherResponseModel?>? data,
  }) {
    return WeatherScreenState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
    );
  }
}

class WeatherScreenStateNotifier extends StateNotifier<WeatherScreenState> {
  final WeatherUseCase weatherUseCase;

  WeatherScreenStateNotifier({required this.weatherUseCase}): super(WeatherScreenState(isLoading: false));

  Future<void> getWeatherData(double lat, double lon) async {
    // Mulai loading
    state = state.copyWith(isLoading: true);

    // Ambil data
    final response = await weatherUseCase.execute(lat, lon);

    // Update state setelah data didapat
    state = state.copyWith(
      isLoading: false,
      data: response,
    );
  }
}

final WeatherScreenStateNotfierProvider = StateNotifierProvider<WeatherScreenStateNotifier, WeatherScreenState>((ref) {
  return WeatherScreenStateNotifier(weatherUseCase: ref.read(weatherUseCaseProvider));
});
