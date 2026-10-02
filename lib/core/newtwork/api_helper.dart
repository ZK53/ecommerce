import 'package:dio/dio.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_keys.dart';
import 'package:stylish/core/newtwork/enpoints.dart';

class ApiHelper {
  late final Dio _dio;

  ApiHelper() {
    _dio = Dio(BaseOptions(baseUrl: Enpoints.base));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            try {
              final refreshToken = CacheHelper.getValue(
                key: CacheKeys.refreshToken,
              );

              final response = await Dio(BaseOptions(baseUrl: Enpoints.base))
                  .post(
                    Enpoints.refreshToken,
                    options: Options(
                      headers: {'Authorization': 'Bearer $refreshToken'},
                    ),
                  );

              final newAccessToken = response.data['access_token'];

              await CacheHelper.setValue(
                key: CacheKeys.accessToken,
                value: newAccessToken,
              );

              final requestOptions = error.requestOptions;

              requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';

              final retryResponse = await _dio.fetch(requestOptions);

              return handler.resolve(retryResponse);
            } catch (e) {
              return handler.next(error);
            }
          }

          handler.next(error);
        },
      ),
    );
  }

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
