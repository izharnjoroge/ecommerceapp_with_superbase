class ItemModel {
  final String item_id;
  final DateTime created_at;
  final String name;
  final String description;
  final String image;
  final String amount;
  final String rating;
  final String categoryId;

  ItemModel({
    required this.item_id,
    required this.created_at,
    required this.name,
    required this.description,
    required this.image,
    required this.amount,
    required this.rating,
    required this.categoryId,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      item_id: json['item_id'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      amount: json['amount'] as String,
      rating: json['rating'] as String,
      categoryId: json['categoryId'] as String,
    );
  }
}
