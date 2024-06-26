// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        if (dioError.message.toString().contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred. ${dioError.message.toString()}";
        break;
      default:
        message = "Something went wrong. ${dioError.message.toString()}";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    print(error);
    switch (statusCode) {
      case 400:
        return 'Bad request. Error: ${error.toString()}';
      case 401:
        return 'Unauthorized. Error: ${error.toString()}';
      case 403:
        return 'Forbidden. Error: ${error.toString()}';
      case 404:
        return "Resource Not Found. Error: ${error.toString()}";
      case 417:
        return "Exceptation Failed. Error: ${error.toString()}";
      case 500:
        return 'Internal server error. Error: ${error.toString()}';
      case 502:
        return 'Bad gateway. Error: ${error.toString()}';
      default:
        return 'Oops something went wrong. Error: ${error.toString()}';
    }
  }

  @override
  String toString() => message;
}