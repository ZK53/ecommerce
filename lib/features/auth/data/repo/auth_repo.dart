import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_keys.dart';
import 'package:stylish/core/newtwork/api_helper.dart';
import 'package:stylish/core/newtwork/enpoints.dart';
import 'package:stylish/features/auth/data/models/login_response_model.dart';
import 'package:stylish/features/auth/data/models/register_response_model.dart';

class AuthRepo {
  final ApiHelper apiHelper = ApiHelper();

  AuthRepo();

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiHelper.postRequest(
        endPoint: Enpoints.login,
        data: {'email': email, 'password': password},
        isFormData: true,
      );

      final loginResponse = LoginResponseModel.fromJson(response.data);

      await CacheHelper.setValue(
        key: CacheKeys.accessToken,
        value: loginResponse.accessToken,
      );

      await CacheHelper.setValue(
        key: CacheKeys.refreshToken,
        value: loginResponse.refreshToken,
      );

      return loginResponse;
    } catch (e) {
      throw Exception(apiHelper.handleException(e));
    }
  }

  Future<RegisterResponseModel> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    String? image,
  }) async {
    try {
      final response = await apiHelper.postRequest(
        endPoint: Enpoints.register,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'image': image,
        },
        isFormData: true,
      );

      return RegisterResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(apiHelper.handleException(e));
    }
  }
}
