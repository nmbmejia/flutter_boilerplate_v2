import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:template_app/core/config/app_config.dart';
import 'package:template_app/core/constants/app_constants.dart';

/// Shared HTTP client. Use for API calls across features.
/// Base URL from [kApiBaseUrl]; register once (e.g. in main) via Get.put(ApiService()).
class ApiService {
  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: kApiBaseUrl,
        connectTimeout: const Duration(seconds: AppConstants.apiTimeoutSeconds),
        receiveTimeout: const Duration(seconds: AppConstants.apiTimeoutSeconds),
      ),
    );
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => debugPrint(obj.toString()),
        ),
      );
    }
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          // Optional: 401 → logout, 5xx → show generic error, etc.
          // if (error.response?.statusCode == 401) { Get.offAllNamed(Routes.login); }
          handler.next(error);
        },
      ),
    );
  }

  late final Dio _dio;

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(path, data: data, queryParameters: queryParameters, options: options);
  }
}
