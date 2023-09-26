import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/core/clients/url_constants.dart';
import 'package:spendly_ui/models/user.dart';

class UserClient {
  final Dio _dio = Dio();

  Future<SpendlyResponse<User>> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString(jwtKey);

    try {
      Response response = await _dio.get(
        ClientURLs.getUserInfo,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return SpendlyResponse(User.fromJson(response.data));
    } on DioError catch (e) {
      return SpendlyResponse.error(e.message);
    }
  }
}
