import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/core/network/response_wrapper.dart';
import 'package:weatherapp/core/utils/location.dart';
import 'package:weatherapp/models/weather_response_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherUseCase{
  final WeatherService weatherService;

  WeatherUseCase({required this.weatherService});

  Future<ResponseWrapper<WeatherResponseModel?>> execute() async{
    try {
      // Ambil lokasi lalu memanggil service untuk mendapatkan data cuaca
      Position location = await Location().getCurrentPosition();
      final response = await weatherService.getWeather(location.latitude, location.longitude);
      if (response.statusCode != 200) {
        return ResponseWrapper.error('Gagal ambil data', statusCode: response.statusCode);
      }

      return ResponseWrapper.success(
          WeatherResponseModel.fromJson(response.data),
          statusCode: response.statusCode
      );

    } on DioException catch (e) {
      return ResponseWrapper.error('Network error: ${e.message}');
    } catch (e) {
      return ResponseWrapper.error('Error: ${e.toString()}');
    }
  }
}