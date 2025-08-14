import 'package:weatherapp/models/main_model.dart';
import 'package:weatherapp/models/weather_model.dart';

class WeatherListModel{
  final int? dt;
  final MainModel? main;
  final List<WeatherModel?>? weather;

  WeatherListModel({
    this.dt,
    this.main,
    this.weather,
  });

  factory WeatherListModel.fromJson(Map<String, dynamic> json){
    return WeatherListModel(
      dt: (json['dt'] as num?)?.toInt(),
      main: json['main'] != null ? MainModel.fromJson(json['main']) : null,
      weather: json['weather']?.map<WeatherModel>((e) => WeatherModel.fromJson(e as Map<String, dynamic>)).toList()
    );
  }
}