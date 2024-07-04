class ItemModel {
  final String item_id;
  final String created_at;
  final String name;
  final String description;
  final String image;
  final String amount;
  final String rating;
  final String categoryId;
  int? quantity = 0;
  int? newAmount = 0;

  ItemModel(
      {required this.item_id,
      required this.created_at,
      required this.name,
      required this.description,
      required this.image,
      required this.amount,
      required this.rating,
      required this.categoryId,
      this.quantity,
      this.newAmount});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      item_id: json['item_id'] as String,
      created_at: json['created_at'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      amount: json['amount'] as String,
      rating: json['rating'] as String,
      categoryId: json['categoryId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'item_id': item_id,
        'created_at': created_at,
        'name': name,
        'description': description,
        'image': image,
        'amount': amount,
        'rating': rating,
        'categoryId': categoryId,
        'quantity': quantity
      };

  @override
  String toString() {
    return 'ItemModel(id: $item_id, name: $name, image: $image, price: $amount,quantity: $quantity)';
  }
}
