class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? imagePath;
  final List<dynamic> favoriteProducts;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.imagePath,
    required this.favoriteProducts,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      imagePath: json['image_path'],
      favoriteProducts: json['favorite_products'] ?? [],
    );
  }
}
