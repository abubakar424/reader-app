import 'dart:async';
import 'package:dio/dio.dart' as dio;
import 'api_endpoints.dart';

class ApiHelper {
  static late dio.Dio _dio;
  Duration requestDuration = const Duration(seconds: 10);
  static const String _token = 'token';

  static void initialize() {
    _dio = dio.Dio(dio.BaseOptions(
      baseUrl: ApiEndpoint.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
    ));
  }

  static Future<dio.Response> get(String endpoint,
      {bool requireAuth = true}) async {
    try {
      if (!requireAuth) {
        _dio.options.headers.remove('Authorization');
      }
      return await _dio.get(endpoint);
    } catch (e) {
      rethrow;
    }
  }

  static Future<dio.Response> post(String endpoint,
      {dynamic data, bool requireAuth = true}) async {
    try {
      if (!requireAuth) {
        _dio.options.headers.remove('Authorization');
      }
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<dio.Response> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<dio.Response> delete(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }
}
