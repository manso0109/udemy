import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      responseType: ResponseType.json,
      baseUrl: 'https://api.escuelajs.co/api/v1/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response<dynamic>?> getData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    dio?.options.headers = {
      'Accept-Encoding': 'deflate',
      'Content_Type': 'application/json; charset=utf-8',
      'access_token': token ?? '',
      'Authorization': 'Bearer ${token ?? ''}',
    };
    return await dio?.get(url, queryParameters: query);
  }

  static Future<Response<dynamic>?> postData(
      {required String url,
      dynamic query,
      required Map<String, dynamic> data,
      String? token,
      String? username}) async {
    dio?.options.headers = {
      'Content_Type': 'application/json; charset=utf-8',
      'access_token': token ?? '',
      'Authorization': 'Bearer ${token ?? ''}',
    };
    return await dio?.post(url, queryParameters: query, data: data);
  }

  static Future<Response<dynamic>?> deleteData(
      {required String url,
      dynamic query,
      String? token,
      String? username}) async {
    dio?.options.headers = {
      'Accept-Encoding': 'deflate',
      'Content_Type': 'application/json; charset=utf-8',
      'access_token': token ?? '',
      'Authorization': 'Bearer ${token ?? ''}',
    };
    return await dio?.delete(url, queryParameters: query);
  }

  static Future<Response<dynamic>?> putData(
      {required String url,
      dynamic query,
      required Map<String, dynamic> data,
      String? token,
      String? username}) async {
    dio?.options.headers = {
      'Content_Type': 'application/json; charset=utf-8',
      'access_token': token ?? '',
      'Authorization': 'Bearer ${token ?? ''}',
    };
    return await dio?.put(url, queryParameters: query, data: data);
  }
}
