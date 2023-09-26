import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/core/clients/url_constants.dart';
import 'package:spendly_ui/models/account.dart';

class AccountClient {
  final Dio _dio = Dio();

  Future<dynamic> getAccounts() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString(jwtKey);

    try {
      Response response = await _dio.get(
        ClientURLs.account,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<SpendlyResponse<Account>> createAccount(Account account) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString(jwtKey);

    try {
      Response response = await _dio.post(
        ClientURLs.account,
        data: account.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return SpendlyResponse(Account.fromJson(response.data));
    } on DioError catch (e) {
      return SpendlyResponse.error(
          e.response != null ? e.response?.data : e.message);
    }
  }
}
