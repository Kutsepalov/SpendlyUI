import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/core/clients/url_constants.dart';
import 'package:spendly_ui/models/category.dart';

class CategoryClient {
  final Dio _dio = Dio();

  Future<SpendlyResponse<List<Category>>> getCategories() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString(jwtKey);

    try {
      Response response = await _dio.get(
        ClientURLs.categories,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      List<dynamic> list = response.data;
      return SpendlyResponse(list.map((e) => Category.fromJson(e)).toList());
    } on DioError catch (e) {
      return SpendlyResponse.error(e.response!.data);
    }
  }
}
