class RegisterResponseModel {
  final String message;
  final bool status;

  const RegisterResponseModel({required this.message, required this.status});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }
}
