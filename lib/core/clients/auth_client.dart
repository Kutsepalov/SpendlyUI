import 'package:dio/dio.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/core/clients/url_constants.dart';

class AuthClient {
  final Dio _dio = Dio();

  Future<Response> registerUser() async {
    return Response(requestOptions: RequestOptions(path: ''));
  }

  Future<SpendlyResponse<String>> login(
      String usernameOrEmail, String password) async {
    try {
      Response response = await _dio.post(
        ClientURLs.authentication,
        data: {
          'usernameOrEmail': usernameOrEmail,
          'password': password,
        },
      );
      return SpendlyResponse(response.data);
    } on DioError catch (e) {
      return SpendlyResponse.error(
          e.response != null ? e.response?.data : e.message);
    }
  }

  Future<Response> logout() async {
    return Response(requestOptions: RequestOptions(path: ''));
  }
}
