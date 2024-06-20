class LocationModel {
  final String? area;
  final String? street;
  final String? description;

  LocationModel({this.area, this.street, this.description});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      street: json['street'] as String? ?? '',
      area: json['area'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'area': area ?? '', 'street': street ?? ''};

  @override
  String toString() {
    return 'LocationModel(street: $street, area: $area)';
  }
}

class ListLocationModel {
  final String id;
  final String area;
  final List<String> streets;

  ListLocationModel(
      {required this.id, required this.area, required this.streets});

  factory ListLocationModel.fromJson(Map<String, dynamic> json) {
    return ListLocationModel(
      id: json['id'] as String,
      area: json['area'] as String,
      streets: List<String>.from(json['streets'] as List),
    );
  }

  @override
  String toString() {
    return 'ListLocationModel(id: $id, area: $area, streets: $streets)';
  }
}
