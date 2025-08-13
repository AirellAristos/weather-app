class MainModel{
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final double? pressure;
  final double? humidity;
  final double? seaLevel;
  final double? groundLevel;

  MainModel({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.groundLevel
  });

  factory MainModel.fromJson(Map<String, dynamic> json){
    return MainModel(
      temp: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feels_like'] as num?)?.toDouble(),
      tempMin: (json['temp_min'] as num?)?.toDouble(),
      tempMax: (json['temp_max'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      seaLevel: (json['sea_level'] as num?)?.toDouble(),
      groundLevel: (json['grnd_level'] as num?)?.toDouble(),
    );
  }
}