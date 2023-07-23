
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


import 'api_consumer.dart';



class DioConsumer implements ApiConsumer {
   Dio client;

  DioConsumer({required this.client}) {

    client.options
    ..receiveDataWhenStatusError
     ..followRedirects = false;
    if (kDebugMode) {
      client.interceptors.add(PrettyDioLogger());
    }
  }

  

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters:  queryParameters );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {

      throw Exception('error error error ${error.message}');
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      bool formDataIsEnabled = false,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.post(path,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body);
      return response;
    } on DioException catch (error) {
      throw Exception('error error error ${error.message}');
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await client.put(path, queryParameters: queryParameters, data: body);
      return response;
    } on DioException catch (error) {
      return Exception('error error error ${error.message}');
    }
  }


}


/*extension DioErrorX on DioException {
  bool get isNoConnectionError =>
      type == DioExceptionType.unknown &&
          error is SocketException; // import 'dart:io' for SocketException
}*/

/*if(error.isNoConnectionError){
        throw NoInternetConnectionException();
      }*/