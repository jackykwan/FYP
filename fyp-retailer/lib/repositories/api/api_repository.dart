import 'dart:async';
import 'dart:convert';

import 'package:client_fyp/config/config.dart';
import 'package:client_fyp/dto/checkout_request.dart';
import 'package:client_fyp/dto/transaction.dart';
import 'package:client_fyp/dto/user.dart';
import 'package:dio/dio.dart';

import 'models/api_response.dart';
import 'models/backend_error.dart';

class ApiRepositoryImpl implements ApiRepository {
  ApiRepositoryImpl(
      {Dio? dio, BaseOptions? baseOptions, Interceptor? interceptor})
      : api = dio ?? Dio() {
    if (baseOptions == null) {
      api.options.baseUrl = envConfig.apiHost;
    } else {
      api.options = baseOptions;
    }
    if (interceptor == null) {
      api.interceptors.add(
        InterceptorsWrapper(
          onRequest: ((options, handler) {
            return handler.next(options);
          }),
          onError: (e, handler) {
            return handler.next(e);
          },
          onResponse: (response, handler) {
            if (response.data['token'] != null) {
              api.options.headers["Authorization"] =
                  "Bearer ${response.data['token']}";
            }
            return handler.next(response);
          },
        ),
      );
    }
  }
  final Dio api;

  @override
  Future<ApiResponse<void>> register(
      {required email, required password, required shopName}) async {
    try {
      final body = {'email': email, 'password': password, 'shopName': shopName};
      await api.post('/users/register', data: jsonEncode(body));
      return const ApiResponse();
    } on DioError catch (e) {
      final data = e.response?.data;
      if (data != null) {
        return ApiResponse(error: BackEndError(message: data.toString()));
      } else {
        final backendError = _handleError(e);
        return ApiResponse(error: backendError);
      }
    }
  }

  @override
  Future<ApiResponse<User>> addStock({
    required String name,
    required double price,
    required int quantity,
    required String id,
  }) async {
    try {
      final body = {
        'name': name,
        'price': price,
        'id': id,
        'quantity': quantity,
      };
      final response = await api.post('/users/stock', data: jsonEncode(body));
      return ApiResponse(result: User.fromJson(response.data));
    } on DioError catch (e) {
      final data = e.response?.data;
      if (data != null) {
        return ApiResponse(error: BackEndError(message: data.toString()));
      } else {
        final backendError = _handleError(e);
        return ApiResponse(error: backendError);
      }
    }
  }

  @override
  Future<ApiResponse<String>> createCheckout(
      {required CheckoutRequest checkoutRequest}) async {
    try {
      final body = checkoutRequest.toJson();
      final response =
          await api.post('/users/checkout/create', data: jsonEncode(body));
      return ApiResponse(result: response.data);
    } on DioError catch (e) {
      final data = e.response?.data;
      if (data != null) {
        return ApiResponse(error: BackEndError(message: data.toString()));
      } else {
        final backendError = _handleError(e);
        return ApiResponse(error: backendError);
      }
    }
  }

  @override
  Future<ApiResponse<Transaction>> getTransaction({required String id}) async {
    try {
      final response = await api.get('/users/transaction?id=$id');
      return ApiResponse(result: Transaction.fromJson(response.data));
    } on DioError catch (e) {
      final data = e.response?.data;
      if (data != null) {
        return ApiResponse(error: BackEndError(message: data.toString()));
      } else {
        final backendError = _handleError(e);
        return ApiResponse(error: backendError);
      }
    }
  }

  @override
  Future<ApiResponse<User>> addItem({
    required String stockId,
    required String itemId,
  }) async {
    try {
      final body = {
        'stockId': stockId,
        'itemId': itemId,
      };
      final response =
          await api.post('/users/stock/item', data: jsonEncode(body));
      return ApiResponse(result: User.fromJson(response.data));
    } on DioError catch (e) {
      final data = e.response?.data;
      if (data != null) {
        return ApiResponse(error: BackEndError(message: data.toString()));
      } else {
        final backendError = _handleError(e);
        return ApiResponse(error: backendError);
      }
    }
  }

  BackEndError _handleError(DioError e) {
    if (e.response != null) {
      final dynamic data = e.response!.data;
      final backendError = BackEndError.fromJson(data);
      return backendError;
    } else {
      return BackEndError(
          message: 'unknown error', errorCode: BackendErrorCode.unknown);
    }
  }

  @override
  void clearHeaders() {
    for (var k in api.options.headers.keys) {
      if (k != 'content-type') {
        api.options.headers[k] = null;
      }
    }
  }

  @override
  void setJwtToken(String token) {
    api.options.headers['Authorization'] = "Bearer $token";
  }

  @override
  Future<ApiResponse<User>> getUser() async {
    try {
      final result = await api.get('/users/me');
      return ApiResponse(result: User.fromJson(result.data));
    } on DioError catch (e) {
      final data = e.response?.data;
      if (data != null) {
        return ApiResponse(error: BackEndError(message: data.toString()));
      } else {
        final backendError = _handleError(e);
        return ApiResponse(error: backendError);
      }
    }
  }

  @override
  Future<ApiResponse<User>> login(
      {required String email, required String password}) async {
    try {
      final body = {'email': email, 'password': password};
      final result = await api.post('/users/login', data: jsonEncode(body));
      return ApiResponse(result: User.fromJson(result.data));
    } on DioError catch (e) {
      final data = e.response?.data;
      if (data != null) {
        return ApiResponse(error: BackEndError(message: data.toString()));
      } else {
        final backendError = _handleError(e);
        return ApiResponse(error: backendError);
      }
    }
  }
}

abstract class ApiRepository {
  Future<ApiResponse<dynamic>> register({
    required String email,
    required String password,
    required String shopName,
  });
  Future<ApiResponse<dynamic>> login({
    required String email,
    required String password,
  });
  Future<ApiResponse<User>> addStock({
    required String name,
    required double price,
    required int quantity,
    required String id,
  });
  Future<ApiResponse<User>> addItem({
    required String stockId,
    required String itemId,
  });
  Future<ApiResponse<String>> createCheckout({
    required CheckoutRequest checkoutRequest,
  });
  Future<ApiResponse<Transaction>> getTransaction({
    required String id,
  });
  Future<ApiResponse<User>> getUser();
  void clearHeaders();
  void setJwtToken(String token);
}
