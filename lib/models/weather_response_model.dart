import 'package:weatherapp/models/clouds_model.dart';
import 'package:weatherapp/models/coordinate_model.dart';
import 'package:weatherapp/models/main_model.dart';
import 'package:weatherapp/models/sys_model.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/models/wind_model.dart';

class WeatherResponseModel{
  final CoordinateModel? coordinate;
  final WeatherModel? weather;
  final String? base;
  final MainModel? main;
  final double? visibility;
  final WindModel? wind;
  final CloudsModel? cloud;
  final int? dt;
  final SysModel? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  WeatherResponseModel({
    this.coordinate,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.cloud,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json){
    return WeatherResponseModel(
      coordinate: json['coord'] != null ? CoordinateModel.fromJson(json['coord']) : null,
      weather: json['weather'] != null ? WeatherModel.fromJson(json['weather']) : null,
      base: json['base']?.toString(),
      main: json['main'] != null ? MainModel.fromJson(json['main']) : null,
      visibility: (json['visibility'] as num?)?.toDouble(),
      wind: json['wind'] != null ? WindModel.fromJson(json['wind']) : null,
      cloud: json['cloud'] != null ? CloudsModel.fromJson(json['cloud']) : null,
      dt: (json['dt'] as num?)?.toInt(),
      sys: json['sys'] != null ? SysModel.fromJson(json['sys']) : null,
      timezone: (json['timezone'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      name: json['name']?.toString(),
      cod: (json['cod'] as num?)?.toInt()
    );
  }
}