import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  final Dio dio;

  WeatherService({required this.dio});

  Future<Response> getWeather(double lat, double lon) async{
    final appID = dotenv.env['APP_KEY'];
    return await dio.get(
      '/weather',
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': appID,
        'units' : 'metric'
      }
    );
  }
}