class CloudsModel{
  final double? all;

  CloudsModel({
    this.all
  });

  factory CloudsModel.fromJson(Map<String, dynamic> json){
    return CloudsModel(
      all: (json['all'] as num?)?.toDouble()
    );
  }
}

