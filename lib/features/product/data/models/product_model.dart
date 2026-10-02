class ProductModel {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final double rating;
  final bool isFavorite;
  final int bestSeller;
  final int categoryId;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.rating,
    required this.isFavorite,
    required this.bestSeller,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imagePath: json['image_path'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      isFavorite: json['is_favorite'],
      bestSeller: json['best_seller'],
      categoryId: json['category']['id'],
    );
  }
}
