class SysModel{
  final String? country;
  final int? sunrise;
  final int? sunset;

  SysModel({
    this.country,
    this.sunrise,
    this.sunset
  });

  factory SysModel.fromJson(Map<String, dynamic> json){
    return SysModel(
      country: json['country']?.toString(),
      sunrise: (json['sunrise'] as num?)?.toInt(),
      sunset: (json['sunset'] as num?)?.toInt()
    );
  }
}