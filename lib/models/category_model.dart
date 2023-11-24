class CategoryModel {
  int? id;
  final String categoryName;
  String? url;

  CategoryModel({
    this.id,
    required this.categoryName,
    this.url,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      categoryName: json['name'] as String,
      url: json['icon_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': categoryName,
      'icon_url': url,
    };
  }
}
