import 'package:dio/dio.dart';
import '../../../core/helpers/app_constants.dart';
import '../../../core/helpers/local_storage.dart';

class ApiService {
  final Dio dio;
  final LocalStorage storage;

  ApiService(this.dio, this.storage);



  /// post request
  Future<Response> post({
    required String endPoint,
    dynamic data,
    dynamic params,
    bool auth = true,
  }) async {
    Map<String, dynamic>? headers;

    String token = '';
    String clientID = '';
    if (auth) {
      token = AppConstants.authorization;
      clientID = AppConstants.clientID;

      if (token.isNotEmpty) {
        headers = {
          "Authorization": 'Bearer $token',
          "Client-ID": clientID
        };
      } else {

      }
    }
    if (data is Map<String, dynamic>?) {
      data = {
        if (data != null) ...data,
      };
    }
    var response = await dio.post(endPoint,
        data: data,
        queryParameters: params,
        options: Options(headers: headers));
    return response;
  }


}
