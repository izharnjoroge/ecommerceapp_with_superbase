class CarouselModel {
  final String id;
  final String created_at;
  final String name;
  final String url;

  CarouselModel(
      {required this.id,
      required this.created_at,
      required this.name,
      required this.url});

  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    return CarouselModel(
      id: json['id'] as String,
      created_at: json['created_at'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': created_at,
      'name': name,
      'url': url,
    };
  }
}
