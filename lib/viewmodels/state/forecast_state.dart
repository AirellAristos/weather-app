import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/core/network/response_wrapper.dart';
import 'package:weatherapp/models/weather_forecast_model.dart';
import 'package:weatherapp/usecases/forecast_usecase.dart';
import 'package:weatherapp/viewmodels/provider/weather_screen_provider.dart';

class ForecastState {
  final bool isLoading;
  final ResponseWrapper<WeatherForecastModel?>? response;

  ForecastState({
    required this.isLoading,
    this.response,
  });

  ForecastState copyWith({
    bool? isLoading,
    ResponseWrapper<WeatherForecastModel?>? response,
  }) {
    return ForecastState(
      isLoading: isLoading ?? this.isLoading,
      response: response ?? this.response,
    );
  }
}

class ForecastStateNotifier extends StateNotifier<ForecastState>{
  final ForecastUseCase forecastUseCase;

  ForecastStateNotifier({required this.forecastUseCase}) : super(ForecastState(isLoading: false));

  Future<void> getForecastData() async{
    state = state.copyWith(isLoading: true);

    final response = await forecastUseCase.execute();

    state = state.copyWith(
      isLoading: false,
      response: response
    );
  }
}

final forecastStateNotifierProvider = StateNotifierProvider<ForecastStateNotifier, ForecastState>((ref) {
  return ForecastStateNotifier(forecastUseCase: ref.read(forecastUseCaseProvider));
});
