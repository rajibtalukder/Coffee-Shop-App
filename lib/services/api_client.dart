import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../utils/utils.dart';
import 'api_exception.dart';

class ApiClient {
  //GET
  Future<dynamic> get(String endPoint, {dynamic header, dynamic query}) async {
    var uri = Uri.parse(baseUrl + endPoint).replace(queryParameters: query);
    try {
      var response = await http
          .get(uri, headers: header)
          .timeout(const Duration(seconds: 20));

      return _processResponse(response);
    } on SocketException {
      //throw ProcessDataException("No internet connection", uri.toString());
      Utils.showLoading('No Internet Connection!');
    } on TimeoutException {
      throw ProcessDataException("Not responding in time", uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String endPoint,{dynamic payloadObj,
    dynamic header, String? differentBaseUrl}) async {
    var uri = Uri.parse((differentBaseUrl ?? baseUrl) + endPoint);
    try {
      var response = await http
          .post(uri, body: jsonEncode(payloadObj), headers: header)
          .timeout(const Duration(seconds: 20));
      print("--------------------- response ------------------------");
      print(response.body);
      Utils.hidePopup();
      Utils.showSnackBar(response.body);


      return _processResponse(response);
    } on SocketException {
      throw ProcessDataException("No internet connection", uri.toString());
    } on TimeoutException {
      throw ProcessDataException("Not responding in time", uri.toString());
    }
  }

  //PUT
  Future<dynamic> put(String endPoint, dynamic payloadObj,
      {dynamic header}) async {
    var uri = Uri.parse(baseUrl + endPoint);
    try {
      var response = await http
          .put(uri, body: payloadObj, headers: header)
          .timeout(const Duration(seconds: 20));

      return _processResponse(response);
    } on SocketException {
      throw ProcessDataException("No internet connection", uri.toString());
    } on TimeoutException {
      throw ProcessDataException("Not responding in time", uri.toString());
    }
  }

  //DELETE
  Future<dynamic> delete(String endPoint,
      {dynamic header, dynamic query}) async {
    var uri = Uri.parse(baseUrl + endPoint).replace(queryParameters: query);
    try {
      var response = await http
          .delete(uri, headers: header)
          .timeout(const Duration(seconds: 20));
      return _processResponse(response);
    } on SocketException {
      throw ProcessDataException("No internet connection", uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException("Not responding in time", uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    var jsonResponse = utf8.decode(response.bodyBytes);
    String? message;
    try{
      message = jsonDecode(jsonResponse)["message"];
    }catch(e){}


    switch (response.statusCode) {
      case 200:
        return jsonResponse;
      case 201:
        return jsonResponse;
      case 302:
        throw UnAuthorizedException(
            message ?? "Unknown error occur", response.request!.url.toString());
      case 400:
        throw BadRequestException(
            message ?? "Unknown error occur", response.request!.url.toString());
      case 403:
        throw UnAuthorizedException(
            message ?? "Unknown error occur", response.request!.url.toString());
      case 422:
        throw UnAuthorizedException(
            message ?? "Unknown error occur", response.request!.url.toString());
      case 500:
        throw InternalServerException(
            message ?? "Unknown error occur", response.request!.url.toString());
      default:
        throw ProcessDataException(
            "Error occurred with code ${response.statusCode}",
            response.request!.url.toString());
    }
  }
}
