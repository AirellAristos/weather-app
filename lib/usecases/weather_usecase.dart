import 'package:weatherapp/core/network/response_wrapper.dart';
import 'package:weatherapp/models/weather_response_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherUseCase{
  final WeatherService weatherService;

  WeatherUseCase({required this.weatherService});

  Future<ResponseWrapper<WeatherResponseModel?>> execute(double lat, double lon) async{
    try {
      final response = await weatherService.getWeather(lat, lon);

      if(response.statusCode != 200)  {
        return ResponseWrapper.error('Gagal ambil data', statusCode: response.statusCode);
      }

      return ResponseWrapper.success(WeatherResponseModel.fromJson(response.data), statusCode:  response.statusCode);

    }catch (e){
      return ResponseWrapper.error(e.toString());
    }
  }
}