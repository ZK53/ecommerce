import 'user_model.dart';

class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final bool status;
  final UserModel user;

  const LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      status: json['status'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
