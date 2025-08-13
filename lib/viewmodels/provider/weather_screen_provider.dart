import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/usecases/weather_usecase.dart';

final dioProvider = Provider<Dio>((ref) {
  final baseURL = dotenv.env['BASE_URL'];
  return Dio(BaseOptions(
    baseUrl: baseURL!,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));
});

final webServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService(dio: ref.read(dioProvider));
});

final weatherUseCaseProvider = Provider<WeatherUseCase>((ref) {
  return WeatherUseCase(weatherService: ref.read(webServiceProvider));
});
