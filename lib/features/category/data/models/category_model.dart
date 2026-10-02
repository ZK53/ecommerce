class CategoryModel {
  final int id;
  final String title;
  final String description;
  final String imagePath;

  CategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imagePath: json['image_path'],
    );
  }
}
