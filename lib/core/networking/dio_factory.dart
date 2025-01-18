import 'package:dio/dio.dart';
import '../../../core/networking/api_urls.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Dio
class DioFactory {
  static Dio? dio;

  ///Private Construct as i don't want to allow creating instance of this class
  DioFactory._();

  static Future<Dio> getDio() async {
    Duration timeOut = const Duration(seconds: 30);
    if (dio == null) {
      dio = Dio();

      dio!
        ..options.baseUrl = ApiUrls.baseUrl
        ..options.headers = {
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
        }
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors
      ?..add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
        ),
      )
      ..add(
        InterceptorsWrapper(
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              // If the new access token is null or empty, then logout the user
            }

            return handler.next(e);
          },
        ),
      );
  }
}
