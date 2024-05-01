import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../env/environment.dart';
import '../helpers/global_helpers.dart';
import '../models/general_response.dart';
import '../provider/functional_provider.dart';
import '../widget/alerts_template.dart';

class InterceptorHttp {
  Future<GeneralResponse> request(
    BuildContext context,
    String method,
    String endPoint,
    dynamic body, {
    bool showLoading = true,
    Map<String, dynamic>? queryParameters,
    List<http.MultipartFile>? multipartFiles,
    Map<String, String>? multipartFields,
    String requestType = "JSON",
    Function(int sentBytes, int totalBytes)? onProgressLoad,
  }) async {
    final urlService = Environment().config?.serviceUrl ?? "no url";

    String url =
        "$urlService$endPoint?${Uri(queryParameters: queryParameters).query}";

    GlobalHelper.logger.t('URL $method: $url');
    body != null
        ? GlobalHelper.logger.log(Level.warning, 'body: ${json.encode(body)}')
        : null;
    queryParameters != null
        ? GlobalHelper.logger.log(
            Level.warning, 'queryParameters: ${json.encode(queryParameters)}')
        : null;

    GeneralResponse generalResponse =
        GeneralResponse(data: null, message: "", error: true);

    final fp = Provider.of<FunctionalProvider>(context, listen: false);

    final keyLoading = GlobalHelper.genKey();
    final keyError = GlobalHelper.genKey();

    String? messageButton;
    void Function()? onPress;

    try {
      http.Response response;
      Uri uri = Uri.parse(url);

      if (showLoading) {
        fp.showAlertLoading(key: keyLoading, content: const AlertLoading());
        await Future.delayed(const Duration(milliseconds: 600));
      }

      String tokenSesion = "";

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": (requestType == 'JSON') ? tokenSesion : tokenSesion,
        //"Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9ggg3d3cudmlhbWF0aWNhLmNvbSIsImF1ZCI6IjQwOSIsImp0aSI6ImU3YjhhYTFlNWViMTc4NzQ4MzZlZTVjNDI1YjhjYjUzIiwiaWF0IjoxNzA4NjE2NjM3LCJuYmYiOjE3MDg2MTY2MzcsImV4cCI6MTcwODcwMzAzNywiZGF0YSI6eyJjb21pZCI6IjgxMSIsInVzZWlkIjoiNDA5IiwiY29kcGVyIjoiMTExIiwiY29kcGVyZiI6bnVsbH19.yS-IebkFvCTLhdWR_EyfMelvFfBj3fiuaeLoBrkkI2A",
        // "Information": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhbmlvTGVjdGl2byI6MjAyMywiRXN0dWRpYW50ZUlEIjoiMjAyMDAzNSIsIk1hdHLDrWN1bGFJRCI6IjIwMjMwMjc4IiwiQ3Vyc29JRCI6IjM3IiwiUGFyYWxlbG9JRCI6IjEiLCJVcmxCYXNlIjoiaHR0cHM6Ly9hcGkuZWR1a2FyMzYwLmNvbS9hcGkvdjEvIiwiRmVjaGFEZXNkZVByZW1hdHJpY3VsYSI6IjIwMjEtMDUtMjUiLCJGZWNoYUhhc3RhUHJlbWF0cmljdWxhIjoiMjAyMS0xMC0wMSIsImlhdCI6MTcwODYxNjYzOH0.VahYL38_LKH7TKfPSBxi_hQdgv2BaS3ceVojxk0mZlc"
        //  "cod_empresa": '611'
        // "versionName": '${packageInfo.version} ${AppConfig.appEnv.environmentName}',
        // "versionCode": packageInfo.buildNumber
        // "versionName": '1.8.10 DEV',
        // "versionCode": "1"
      };

      GlobalHelper.logger.w(headers);

      int responseStatusCode = 0;
      String responseBody = "";

      switch (requestType) {
        case "JSON":
          switch (method) {
            case "POST":
              response = await http.post(uri,
                  headers: headers,
                  body: body != null ? json.encode(body) : null);
              //inspect(_response);
              break;
            case "GET":
              response = await http.get(uri, headers: headers);
              break;
            case "PUT":
              response = await http.put(uri,
                  headers: headers,
                  body: body != null ? json.encode(body) : null);
              break;
            case "PATCH":
              response = await http.patch(uri,
                  headers: headers,
                  body: body != null ? json.encode(body) : null);
              break;

            default:
              response = await http.post(uri, body: jsonEncode(body));
              break;
          }
          responseStatusCode = response.statusCode;
          responseBody = response.body;

          GlobalHelper.logger.log(Level.trace, json.decode(responseBody));
          break;
        case "FORM":
          final httpClient = getHttpClient();
          final request = await httpClient.postUrl(Uri.parse(url));

          int byteCount = 0;
          var requestMultipart = http.MultipartRequest(method, Uri.parse(url));
          if (multipartFiles != null) {
            requestMultipart.files.addAll(multipartFiles);
          }
          if (multipartFields != null) {
            requestMultipart.fields.addAll(multipartFields);
          }

          headers.forEach((key, value) {
            request.headers.set("Authorization", tokenSesion);
          });

          debugPrint("TOKEN CARGADO");

          var msStream = requestMultipart.finalize();

          var totalByteLength = requestMultipart.contentLength;

          request.contentLength = totalByteLength;

          request.headers.set(HttpHeaders.contentTypeHeader,
              requestMultipart.headers[HttpHeaders.contentTypeHeader]!);

          Stream<List<int>> streamUpload = msStream.transform(
            StreamTransformer.fromHandlers(
              handleData: (data, sink) {
                sink.add(data);

                byteCount += data.length;

                if (onProgressLoad != null) {
                  onProgressLoad(byteCount, totalByteLength);
                }
              },
              handleError: (error, stack, sink) {
                generalResponse.error = true;
                throw error;
              },
              handleDone: (sink) {
                sink.close();
                // UPLOAD DONE;
              },
            ),
          );

          await request.addStream(streamUpload);

          final httpResponse = await request.close();
          var statusCode = httpResponse.statusCode;

          responseStatusCode = statusCode;
          if (statusCode ~/ 100 != 2) {
            throw Exception(
                'Error uploading file, Status code: ${httpResponse.statusCode}');
          } else {
            await for (var data in httpResponse.transform(utf8.decoder)) {
              responseBody = data;
            }
          }
          break;
      }

      GlobalHelper.logger.w('statusCode: ${responseStatusCode.toString()}');

      switch (responseStatusCode) {
        case 200:
          var responseDecoded = json.decode(responseBody);
          generalResponse.data = responseDecoded["data"];
          if (responseDecoded["error"]) {
            generalResponse.error = true;
            generalResponse.message = responseDecoded["message"];
            fp.dismissAlertLoading(key: keyLoading);
          } else {
            generalResponse.error = false;
            generalResponse.message = responseDecoded["message"];
          }
          break;
        case 307:
          generalResponse.error = true;
          generalResponse.message =
              "Ocurrió un error al consultar con los servicios. Intente con una red que le permita el acceso";
          fp.dismissAlertLoading(key: keyLoading);
          break;
        case 401:
          generalResponse.error = true;
          generalResponse.message =
              'Su sesión ha caducado, vuelva a iniciar sesión.';
          messageButton = 'Volver a ingresar';
          onPress = () async {
            fp.clearAllAlert();
          };
          fp.dismissAlertLoading(key: keyLoading);
          break;
        default:
          generalResponse.error = true;
          generalResponse.message = json.decode(responseBody)["message"];
          fp.dismissAlertLoading(key: keyLoading);
          break;
      }
    } on TimeoutException catch (e) {
      debugPrint('$e');
      generalResponse.error = true;
      generalResponse.message = 'Tiempo de conexión excedido.';
      fp.dismissAlertLoading(key: keyLoading);
    } on FormatException catch (ex) {
      debugPrint(ex.toString());
      fp.dismissAlertLoading(key: keyLoading);
    } on SocketException catch (exSock) {
      GlobalHelper.logger.e("Error por conexion: $exSock");
      generalResponse.error = true;
      generalResponse.message =
          "Verifique su conexión a internet y vuelva a intentar.";
      fp.dismissAlertLoading(key: keyLoading);
    } on Exception catch (e, stacktrace) {
      GlobalHelper.logger.e("Error en request: $stacktrace");
      generalResponse.error = true;
      generalResponse.message = "Ocurrio un error, vuelva a intentarlo.";
      fp.dismissAlertLoading(key: keyLoading);
    }

    if (!generalResponse.error) {
      if (showLoading) {
        fp.dismissAlertLoading(key: keyLoading);
      }
    } else {
      fp.showAlert(
        key: keyError,
        content: AlertGeneric(
          content: ErrorGeneric(
            keyToClose: keyError,
            message: generalResponse.message,
            messageButton: messageButton,
            onPress: onPress,
          ),
        ),
      );
    }
    return generalResponse;
  }

  HttpClient getHttpClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}
