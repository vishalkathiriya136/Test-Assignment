import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import 'constants.dart';

Map<String, String> buildHeaderTokens() {
  Map<String, String> header = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  };
  // if (userResponse?.data?.accessToken != null) {
  //   header.putIfAbsent(HttpHeaders.authorizationHeader,
  //       () => 'Bearer ${userResponse?.data?.accessToken}');
  // }
  log(jsonEncode(header));
  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('$BASE_URL$endPoint');

  log('URL: ${url.toString()}');

  return url;
}

Future<dynamic> multiPart(
    String endPoint,
    BuildContext context,
    Map<String, String> params,
    List<String> filePaths,
    List<String> mediaName) async {
  if (await isNetworkAvailable()) {
    var headers = buildHeaderTokens();

    Uri url = buildBaseUrl(endPoint);
    final multipartRequest = http.MultipartRequest('POST', url);
    debugPrint(' after baseurl.................PRAMS : - ${params.toString()}');
    multipartRequest.fields.addAll(params);
    multipartRequest.headers.addAll(headers);
    debugPrint(' after params.................');
    int index = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    filePaths.forEach((element) async {
      var pic = await http.MultipartFile.fromPath(mediaName[index], element);
      debugPrint(' after pic add UID ................. ${mediaName[index]}');
      index = index + 1;
      multipartRequest.files.add(pic);
      debugPrint(pic.toString());
    });

    log("FILE PRINT  ${multipartRequest.files.toString()}");

    debugPrint(' after pic add.................');
    try {
      final response = await multipartRequest.send();
      debugPrint('error after response.................');
      try {
        var responseByteArray = await response.stream.toBytes();

        log("RESPONSE: STATUSCODE :- ${response.statusCode.toString()} Url :- $url  RESPONSE :- ${utf8.decode(responseByteArray).toString()}");

        return json.decode(utf8.decode(responseByteArray));
      } on FormatException catch (e) {
        debugPrint('error ${e.toString()}');
      }
    } on SocketException {
      return json.decode(
          json.encode({'status': 400, 'message': 'No Internet connection'}));
    }
  }
}

Future<Response> buildHttpResponse(String endPoint,
    {HttpMethod method = HttpMethod.GET, required Map request}) async {
  if (await isNetworkAvailable()) {
    var headers = buildHeaderTokens();

    Uri url = buildBaseUrl(endPoint);
    log("URL::: $url  headers:: $headers REQUEST :::: ${jsonEncode(request)}");
    Response response;

    try {
      if (method == HttpMethod.POST) {
        log('Request: $request');

        response =
            await http.post(url, body: jsonEncode(request), headers: headers);
      } else if (method == HttpMethod.DELETE) {
        response = await delete(url, headers: headers);
      } else if (method == HttpMethod.PUT) {
        response = await put(url, body: jsonEncode(request), headers: headers);
      } else {
        response = await get(url, headers: headers);
      }

      log('RESPONSE: $response');
      log('RESPONSE BODY: ${response.body}');
      if (response.statusCode == 422) {
        debugPrint(jsonDecode(response.body));
      }

      return response;
    } catch (e) {
      if (e is SocketException) {
        throw "Seems like your internet is not working or server is not reachable.";
      } else if (e is TimeoutException) {
        throw "Request Timeout please try Again";
      } else {
        throw "Something went wrong please try Again";
      }
    }
  } else {
    throw "Please check your internet and try again.";
  }
}

Future handleResponse(Response response, [avoidTokenError]) async {
  if (!await isNetworkAvailable()) {
    throw "Please check your internet and try again.";
  }
  var json = jsonDecode(response.body);
  if (response.statusCode.isSuccessful() && !(json.containsKey('errors'))) {
    return jsonDecode(response.body);
  } else {
    if (response.body.isJson()) {
      if (json.containsKey('errors')) {
        String errorMessages = "";
        json["errors"].forEach((key, messages) {
          for (var message in messages) {
            errorMessages += "$message\n";
          }
        });
        throw errorMessages.toString();
      } else {
        String errorMessages = json["message"];
        throw errorMessages.toString();
      }
    } else {
      try {
        var body = jsonDecode(response.body);
        throw body['message'];
      } on Exception catch (e) {
        log(e);
        throw errorSomethingWentWrong;
      }
    }
  }
}

enum HttpMethod { GET, POST, DELETE, PUT }
