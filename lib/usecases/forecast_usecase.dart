import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/core/network/response_wrapper.dart';
import 'package:weatherapp/core/utils/location.dart';
import 'package:weatherapp/models/weather_forecast_model.dart';
import 'package:weatherapp/services/forecast_service.dart';

class ForecastUseCase{
  final ForecastService forecastService;

  ForecastUseCase({required this.forecastService});

  Future<ResponseWrapper<WeatherForecastModel?>> execute() async{
    try {
      // Ambil lokasi lalu memanggil service untuk mendapatkan data forecast cuaca
      Position location = await Location().getCurrentPosition();
      final response = await forecastService.getForecast(location.latitude, location.longitude);
      if (response.statusCode != 200) {
        return ResponseWrapper.error('Gagal ambil data', statusCode: response.statusCode);
      }

      return ResponseWrapper.success(
          WeatherForecastModel.fromJson(response.data),
          statusCode: response.statusCode
      );

    } on DioException catch (e) {
      return ResponseWrapper.error('Network error: ${e.message}');
    } catch (e) {
      return ResponseWrapper.error('Error: ${e.toString()}');
    }
  }
}