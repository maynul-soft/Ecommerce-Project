import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

part 'network_response.dart';

class NetworkClient {
  final VoidCallback onUnAuthorize;
  String defaultErrorMessage = 'Something went wrong';
  Map<String, String> Function() commonHeader;
  final VoidCallback onSocketException;

  final Logger _logger = Logger();

  NetworkClient({required this.onSocketException, required this.onUnAuthorize, required this.commonHeader});

  Future<NetworkResponse> getRequest({required String url}) async {

    try {
      Uri uri = Uri.parse(url);

      _logger.i('''
      pre request log
      ==> $url
      ''');

      Response response = await get(
        uri,
        headers: commonHeader(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodeJson = jsonDecode(response.body);
        _logger.i('''
      post request log
      ==> $url
      ==> $decodeJson
      ''');
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseBody: decodeJson,
        );
      } else if (response.statusCode == 401|| response.statusCode == 402 || response.statusCode == 403) {
        _logger.e('status ${response.statusCode}, body==> ${response.body} unAuth');
        onUnAuthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: defaultErrorMessage,
        );
      } else {
        var decodedJson = jsonDecode(response.body);
        _logger.d(decodedJson);
        _logger.i('''
      post request log
      ==> $url
      ==> $decodedJson
      ''');
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedJson['msg'],
        );
      }
    } on SocketException {
      onSocketException();
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: 'Check your network connection and try again later',
      );
    } catch (e) {
      _logger.e(e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      // Map<String, String> commonHeader = {
      //   "Content-Type": "application/json",
      //   "token": Get.find<AuthController>().token ?? ''
      // };

      _logger.i('''
      pre request log
      ==> $url
      ==> ${jsonEncode(body)}
      ''');



      Response response = await post(
        uri,
        body: jsonEncode(body),
        headers: commonHeader(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedJson = jsonDecode(response.body);
        _logger.d(decodedJson);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseBody: decodedJson,
        );
      } else if (response.statusCode == 401) {
        _logger.e('status ${response.statusCode}, body==> ${response.body} unAuth');
        onUnAuthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: defaultErrorMessage,
        );
      } else {
        var decodedJson = jsonDecode(response.body);
        _logger.d(decodedJson);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedJson['msg'] ?? defaultErrorMessage,
        );
      }
    } on SocketException {
      onSocketException();
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: 'Check your network connection and try again later',
      );
    } catch (e) {
      print(e);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> putRequest({
    required String url,
    required Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await put(uri, body: jsonEncode(body));

      _logger.i(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseBody: decodedJson,
        );
      } else if (response.statusCode == 401) {
        onUnAuthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: defaultErrorMessage,
        );
      } else {
        var decodedJaon = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedJaon,
        );
      }
    } on SocketException {
      onSocketException();
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: 'Check your network connection and try again later',
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> patchRequest({
    required String url,
    required Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await patch(uri, body: jsonEncode(body),headers: commonHeader());

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseBody: decodedJson,
        );
      } else if (response.statusCode == 401) {
        onUnAuthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: defaultErrorMessage,
        );
      } else {
        var decodedJaon = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedJaon,
        );
      }
    } on SocketException {
      onSocketException();
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: 'Check your network connection and try again later',
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> deleteRequest({
    required String url,

  }) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await delete(uri,headers: commonHeader());

      _logger.e('Post log ==> ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseBody: decodedJson,
        );
      } else if (response.statusCode == 401) {
        onUnAuthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: defaultErrorMessage,
        );
      } else {
        var decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedJson,
        );
      }
    } on SocketException {
      onSocketException();
      return NetworkResponse(
        isSuccess: false,
        statusCode: -10,
        errorMessage: 'Check your network connection and try again later',
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }
}

preRequestLog() {}
