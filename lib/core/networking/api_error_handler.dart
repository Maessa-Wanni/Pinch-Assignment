import 'package:dio/dio.dart';
import '../../../core/networking/empty_response.dart';
import 'api_urls.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  API_LOGIC_ERROR,
  DEFAULT
}

class ResponseCode {
  ///200
  static const int SUCCESS = 200; // success with data
  ///201
  static const int NO_CONTENT = 201; // success with no data (no content)
  ///400
  static const int BAD_REQUEST = 400; // failure, API rejected request
  ///401
  static const int UNAUTORISED = 401; // failure, user is not authorised
  ///403
  static const int FORBIDDEN = 403; //  failure, API rejected request
  ///500
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  ///404
  static const int NOT_FOUND = 404; // failure, not found
  ///422
  static const int API_LOGIC_ERROR = 422; // API , lOGIC ERROR

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = ApiErrors.ok; // success with data
  static const String NO_CONTENT =
      ApiErrors.ok; // success with no data (no content)
  static const String BAD_REQUEST =
      ApiErrors.badRequestError; // failure, API rejected request
  static const String UNAUTORISED =
      ApiErrors.unauthorizedError; // failure, user is not authorised
  static const String FORBIDDEN =
      ApiErrors.forbiddenError; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      ApiErrors.internalServerError; // failure, crash in server side
  static const String NOT_FOUND =
      ApiErrors.notFoundError; // failure, crash in server side
  static const String API_LOGIC_ERROR =
      ApiErrors.apiLogicError; // API , lOGIC ERROR

  // local status code
  static const String CONNECT_TIMEOUT = ApiErrors.timeoutError;
  static const String CANCEL = ApiErrors.defaultError;
  static const String RECIEVE_TIMEOUT = ApiErrors.timeoutError;
  static const String SEND_TIMEOUT = ApiErrors.timeoutError;
  static const String CACHE_ERROR = ApiErrors.cacheError;
  static const String NO_INTERNET_CONNECTION = ApiErrors.noInternetError;
  static const String DEFAULT = ApiErrors.defaultError;
}

extension DataSourceExtension on DataSource {
  EmptyResponse getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return EmptyResponse(errors: [
          Errors(status: ResponseCode.SUCCESS, title: ResponseMessage.SUCCESS)
        ]);
      case DataSource.NO_CONTENT:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.NO_CONTENT,
              title: ResponseMessage.NO_CONTENT)
        ]);
      case DataSource.BAD_REQUEST:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.BAD_REQUEST,
              title: ResponseMessage.BAD_REQUEST)
        ]);
      case DataSource.FORBIDDEN:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.FORBIDDEN, title: ResponseMessage.FORBIDDEN)
        ]);
      case DataSource.UNAUTORISED:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.UNAUTORISED,
              title: ResponseMessage.UNAUTORISED)
        ]);
      case DataSource.NOT_FOUND:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.NOT_FOUND, title: ResponseMessage.NOT_FOUND)
        ]);
      case DataSource.INTERNAL_SERVER_ERROR:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.INTERNAL_SERVER_ERROR,
              title: ResponseMessage.INTERNAL_SERVER_ERROR)
        ]);
      case DataSource.CONNECT_TIMEOUT:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.CONNECT_TIMEOUT,
              title: ResponseMessage.CONNECT_TIMEOUT)
        ]);
      case DataSource.CANCEL:
        return EmptyResponse(errors: [
          Errors(status: ResponseCode.CANCEL, title: ResponseMessage.CANCEL)
        ]);
      case DataSource.RECIEVE_TIMEOUT:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.RECIEVE_TIMEOUT,
              title: ResponseMessage.RECIEVE_TIMEOUT)
        ]);
      case DataSource.SEND_TIMEOUT:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.SEND_TIMEOUT,
              title: ResponseMessage.SEND_TIMEOUT)
        ]);
      case DataSource.CACHE_ERROR:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.CACHE_ERROR,
              title: ResponseMessage.CACHE_ERROR)
        ]);
      case DataSource.NO_INTERNET_CONNECTION:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.NO_INTERNET_CONNECTION,
              title: ResponseMessage.NO_INTERNET_CONNECTION)
        ]);
      case DataSource.API_LOGIC_ERROR:
        return EmptyResponse(errors: [
          Errors(
              status: ResponseCode.API_LOGIC_ERROR,
              title: ResponseMessage.API_LOGIC_ERROR)
        ]);
      case DataSource.DEFAULT:
        return EmptyResponse(errors: [
          Errors(status: ResponseCode.DEFAULT, title: ResponseMessage.DEFAULT)
        ]);
    }
  }
}

EmptyResponse _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();

    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.data != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return EmptyResponse(
          errors: [
            Errors(
              title: error.response?.data[0]['title'] as String,
              status: error.response?.data[0]['status'] as int,
            )
          ],
        );
      } else {
        return DataSource.DEFAULT.getFailure();
      }

    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();

    default:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return EmptyResponse(errors: [
          Errors(
              title: error.response?.statusMessage ?? "",
              status: error.response?.statusCode ?? 0)
        ]);
      } else {
        return DataSource.DEFAULT.getFailure();
      }
  }
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}

class ErrorHandler implements Exception {
  late EmptyResponse failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      /// dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      /// default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}
