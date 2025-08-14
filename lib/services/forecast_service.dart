import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ForecastService {
  final Dio dio;

  ForecastService({required this.dio});

  Future<Response> getForecast(double lat, double lon) async{
    final appID = dotenv.env['APP_KEY'];
    return await dio.get(
        '/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': appID,
          'units' : 'metric'
        }
    );
  }
}