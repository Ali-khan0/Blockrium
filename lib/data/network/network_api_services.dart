import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../app_exception.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    // print(responseJson);
    return responseJson;
  }

  @override
  Future<dynamic> getApiBearer(String url) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token =
        // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbXljYXNoYmFjay5wa1wvYXNkYXdhalwvYXBpXC92MVwvbG9naW4iLCJpYXQiOjE2NzczMTY1NzIsIm5iZiI6MTY3NzMxNjU3MiwianRpIjoiY2wwVDhwdVI2ZU41OFpyMiIsInN1YiI6MTYsInBydiI6IjhlZjk5YTJmNTAyMTQwYThjMDQxZDczZDJlNTkwNGJhYjBmNGM5NDMifQ.OrlbWqBQDmCpmjDoP0Ww_H6xSQm2KxtG80tkmDuU_yA";
        sp.getString("token");
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    // print(responseJson);
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } catch (error) {
      // Convert the error response to a map format with "status" key
      final errorResponse = {
        "status": 500, // Set an appropriate status code for server errors
        "message": error.toString(),
      };
      throw errorResponse;
    }

    if (responseJson is Map && responseJson.containsKey("status")) {
      final statusCode = responseJson["status"];
      if (statusCode < 200 || statusCode >= 300) {
        throw responseJson;
      }
    }

    if (kDebugMode) {
      print("=========>>> Post APi Response JSON: $responseJson");
    }

    return responseJson;
  }

  @override
  Future<dynamic> postApiBearer(var data, String url) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url),
              headers: {'Authorization': 'Bearer $token'}, body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }

    // print(responseJson);
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException;
      default:
        throw FetchDataException(
            'Error occured while communicating with the server' +
                response.statusCode.toString());
    }
  }
}
