class SliderModel {
  final int id;
  final String title;
  final String description;
  final String imagePath;

  SliderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imagePath: json['image_path'],
    );
  }
}
