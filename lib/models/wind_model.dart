class WindModel{
  final double? speed;
  final double? deg;
  final double? gust;

  WindModel({
    this.speed,
    this.deg,
    this.gust
  });

  factory WindModel.fromJson(Map<String, dynamic> json){
    return WindModel(
      speed: (json['speed'] as num?)?.toDouble(),
      deg: (json['deg'] as num?)?.toDouble(),
      gust: (json['gust'] as num?)?.toDouble()
    );
  }
}