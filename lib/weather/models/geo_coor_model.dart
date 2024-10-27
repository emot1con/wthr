class GeoCoorModels {
  final List<GeoCoorModel> geoCoor;
  GeoCoorModels({required this.geoCoor});

  factory GeoCoorModels.fromJson(List<dynamic> json) => GeoCoorModels(
        geoCoor: json.map((item) => GeoCoorModel.fromJson(item)).toList(),
      );
}

class GeoCoorModel {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String? state;

  GeoCoorModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory GeoCoorModel.fromJson(Map<String, dynamic> json) => GeoCoorModel(
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"],
      );
}
