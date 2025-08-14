import 'package:weatherapp/models/weather_list_model.dart';

class WeatherForecastModel{
  final String? cod;
  final int? message;
  final int? cnt;
  final List<WeatherListModel?>? list;

  WeatherForecastModel({
    this.cod,
    this.message,
    this.cnt,
    this.list
  });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json){
    final today = DateTime.now();
    return WeatherForecastModel(
      cod: json['cod']?.toString(),
      message: (json['message'] as num?)?.toInt(),
      cnt: (json['cnt'] as num?)?.toInt(),
      list: (json['list'] as List<dynamic>?)
          ?.where((e) {
        final dateStr = e['dt_txt'] as String?;
        if (dateStr == null) return false;

        final date = DateTime.parse(dateStr);
        return date.year == today.year &&
            date.month == today.month &&
            date.day == today.day;
      }).map<WeatherListModel>((e) => WeatherListModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}