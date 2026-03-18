import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../../config/env.dart';

class ApiService {
  late final Dio _dio;
  final _storage = GetStorage();

  ApiService({Dio? dio}) {
    _dio = dio ?? Dio(BaseOptions(
      baseUrl: Environment.apiBaseUrl,
      // Dio v5 expects Duration for timeouts
      connectTimeout: Environment.apiTimeoutDuration,
      receiveTimeout: Environment.apiTimeoutDuration,
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // Add interceptor to include JWT token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _storage.read('auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final resp = await _dio.get(path, queryParameters: queryParameters);
      return resp.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final resp = await _dio.post(path, data: data);
      return resp.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final resp = await _dio.put(path, data: data);
      return resp.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<dynamic> delete(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final resp = await _dio.delete(path, queryParameters: queryParameters);
      return resp.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  // Helper for RPC-like POST endpoints
  Future<dynamic> postRpc(String path, {dynamic data}) async {
    return post(path, data: data);
  }
}
