import 'package:dio/dio.dart';
import 'end_points.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baserUrl;
  }

//!POST
  @override
  Future post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
        bool isContentType = false,
      }) async {
    // if (kToken != null && kToken != '') {
    //   dio.options.headers['Authorization'] = 'Bearer $kToken';
    //   dio.options.headers['Content-Type'] = 'multipart/form-data';
    // }
    if (isContentType) {
      dio.options.headers['Content-Type'] = 'application/json';
    }

    var response = await dio.post(
      path,
      data: isFormData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

//!GET
  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    // if (kToken != null && kToken != '') {
    //   dio.options.headers['Authorization'] = 'Bearer $kToken';
    // }
    var res = await dio.get(path, data: data, queryParameters: queryParameters);
    return res.data;
  }

//!DELETE
  @override
  Future delete(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    var res = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return res.data;
  }

//!PATCH
  @override
  Future patch(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false}) async {
    var res = await dio.patch(
      path,
      data: isFormData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );
    return res.data;
  }
}