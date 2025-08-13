class CoordinateModel{
  final double? lon;
  final double? lat;

  CoordinateModel({
    this.lon,
    this.lat
  });

  factory CoordinateModel.fromJson(Map<String, dynamic> json){
    return CoordinateModel(
      lon: (json['lon'] as num?)?.toDouble(),
      lat:(json['lat'] as num?)?.toDouble()
    );
  }
}



