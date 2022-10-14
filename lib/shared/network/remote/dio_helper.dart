import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio=Dio();
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'lang':'ar'
          }),
    );
  }

  static Future<Response> getData({
    required Map<String, dynamic> query,
    required String url,
    String? lang,
    String? token,
  }) async {
    dio!.options.headers=
    {
      'lang':lang,
      'Authorization':token,

    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {
        Map<String, dynamic>? query,
      required String url,
      required Map<String, dynamic> data,
        String? lang,
        String? token,
      }) async {

    dio!.options.headers=
    {
      'lang':lang,
      'Authorization':token,

    };
    return dio!.post(
        url,
       queryParameters: query,
        data: data,
    );
  }
}
