import 'package:dio/dio.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_keys.dart';
import 'package:stylish/core/newtwork/enpoints.dart';

class ApiHelper {
  final Dio _dio = Dio(BaseOptions(baseUrl: Enpoints.base));

  Future<Response> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isPrivate = false,
  }) async {
    return _dio.post(
      endPoint,
      data: data != null
          ? isFormData
                ? FormData.fromMap(data)
                : data
          : null,
      options: Options(
        headers: {
          if (isPrivate)
            'Authorization':
                'Bearer ${CacheHelper.getValue(key: CacheKeys.accessToken)}',
        },
      ),
    );
  }

  Future<Response> getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    bool isPrivate = false,
  }) async {
    return _dio.get(
      endPoint,
      queryParameters: queryParams,
      options: Options(
        headers: {
          if (isPrivate)
            'Authorization':
                'Bearer ${CacheHelper.getValue(key: CacheKeys.accessToken)}',
        },
      ),
    );
  }

  Future<Response> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    bool isPrivate = false,
  }) async {
    return _dio.delete(
      endPoint,
      queryParameters: queryParams,
      options: Options(
        headers: {
          if (isPrivate)
            'Authorization':
                'Bearer ${CacheHelper.getValue(key: CacheKeys.accessToken)}',
        },
      ),
    );
  }

  Future<Response> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isPrivate = false,
  }) async {
    return _dio.put(
      endPoint,
      data: data != null
          ? isFormData
                ? FormData.fromMap(data)
                : data
          : null,
      options: Options(
        headers: {
          if (isPrivate)
            'Authorization':
                'Bearer ${CacheHelper.getValue(key: CacheKeys.accessToken)}',
        },
      ),
    );
  }

  String handleException(Object e) {
    String errorMsg;
    if (e is DioException) {
      if (e.response?.data != null) {
        var errorResponse = e.response?.data as Map<String, dynamic>;
        errorMsg = errorResponse['message'];
      } else {
        errorMsg = 'Network error happened try again later';
      }
    } else {
      errorMsg = 'error happened try again later';
    }
    return errorMsg;
  }
}
