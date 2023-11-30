class CategoryModel {
  final String category_id;
  final String created_at;
  final String name;
  final String url;

  CategoryModel(
      {required this.category_id,
      required this.created_at,
      required this.name,
      required this.url});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      category_id: json['category_id'] as String,
      created_at: json['created_at'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': category_id,
      'created_at': created_at,
      'name': name,
      'url': url,
    };
  }
}
