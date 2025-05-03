import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

enum HttpMethod { get, post, put }

sealed class Result<T> {
  const Result();
  factory Result.ok(T value) => Ok(value);
  factory Result.error(Exception error) => Error(error);
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}

final class Error<T> extends Result<T> {
  const Error(this.error);
  final Exception error;
}

class NetworkService {
  NetworkService._privateConstructor();
  static final NetworkService _instance = NetworkService._privateConstructor();
  factory NetworkService() {
    return _instance;
  }

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // مدة انتهاء المهلة الافتراضية
  final Duration _timeoutDuration = const Duration(seconds: 5);

  Future<Result<T>> request<T>({
    required String url,
    required HttpMethod method,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      http.Response response;
      final requestHeaders = {
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      };

      switch (method) {
        case HttpMethod.get:
          final uri = Uri.parse(url).replace(queryParameters: parameters);
          response = await http
              .get(uri, headers: requestHeaders)
              .timeout(Duration(seconds: 5));
          break;
        case HttpMethod.post:
          response = await http
              .post(
                Uri.parse(url),
                headers: requestHeaders,
                body: json.encode(parameters),
              )
              .timeout(Duration(seconds: 5));
          break;
        case HttpMethod.put:
          response = await http
              .put(
                Uri.parse(url),
                headers: requestHeaders,
                body: json.encode(parameters),
              )
              .timeout(Duration(seconds: 5));
          break;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final decodedData = json.decode(response.body);
          if (decodedData is Map<String, dynamic>) {
            final data = fromJson(decodedData);
            return Result.ok(data);
          } else {
            return Result.error(
                Exception('Unexpected data format: Expected a JSON object.'));
          }
        } on FormatException {
          return Result.error(Exception('Error in data formatting.'));
        }
      } else {
        return Result.error(
            Exception('خطأ في الاستجابة: ${response.statusCode}'));
      }
    } on SocketException {
      return Result.error(Exception('لا يوجد اتصال بالإنترنت'));
    } on TimeoutException {
      return Result.error(Exception('انتهت مهلة الاتصال'));
    } catch (e) {
      return Result.error(Exception('حدث خطأ غير متوقع: $e'));
    }
  }
}
