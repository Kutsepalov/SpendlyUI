import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/core/clients/url_constants.dart';
import 'package:spendly_ui/models/record.dart';

class RecordClient {
  final Dio _dio = Dio();

  Future<SpendlyResponse<List<Record>>> getRecords() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString(jwtKey);

    try {
      Response response = await _dio.get(
        ClientURLs.records,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      List list = response.data;
      return SpendlyResponse(list.map((e) => Record.fromJson(e)).toList());
    } on DioError catch (e) {
      return SpendlyResponse.error(e.response!.data);
    }
  }

  Future<SpendlyResponse<Record>> createRecord(Record record) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString(jwtKey);

    try {
      Response response = await _dio.post(
        ClientURLs.records,
        data: record.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return SpendlyResponse(Record.fromJsonSmall(response.data));
    } on DioError catch (e) {
      return SpendlyResponse.error(e.response!.data);
    }
  }
}
