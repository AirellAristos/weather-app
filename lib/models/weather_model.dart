class WeatherModel{
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  WeatherModel({
    this.id,
    this.main,
    this.description,
    this.icon
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
      id: (json['id'] as num?)?.toInt(),
      main: json['main']?.toString(),
      description: json['description']?.toString(),
      icon: json['icon']?.toString()
    );
  }
}