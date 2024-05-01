//Ejemplo de post

// import 'dart:convert';

// import 'package:flutter/material.dart';

// import '../../../env/environment.dart';
// import '../../../shared/helpers/global_helper.dart';
// import '../../../shared/models/general_response.dart';
// import '../../../shared/services/http_interceptor.dart';
// import '../models/activity_response.dart';

// class ActivityService {
//   final urlService = Environment().config?.serviceUrl ?? "no url";
//   InterceptorHttp interceptorHttp = InterceptorHttp();

//   Future<GeneralResponse<ActivityResponse>> getActivity(
//       BuildContext context, Map<String, dynamic> body) async {
//     try {
//       const String url = 'father/ListDetails';

//       GeneralResponse response =
//           await interceptorHttp.request(context, 'POST', url, body, showLoading: true);

//       ActivityResponse? activity;

//       if (!response.error) {
//         activity = activityResponseFromJson(jsonEncode(response.data));
//       }
//       return GeneralResponse(
//           error: response.error, data: activity, message: response.message);
//     } catch (e) {
//       GlobalHelper.logger.e('Error en el ActivityService $e');
//       return GeneralResponse(
//           message: "Error al obtener las actividades de los estudiantes",
//           error: true);
//     }
//   }
// }



//Ejemplo de get



// import 'dart:convert';
// import 'package:edukar/shared/helpers/global_helper.dart';
// import 'package:edukar/shared/models/general_response.dart';
// import 'package:edukar/shared/services/http_interceptor.dart';
// import 'package:flutter/material.dart';

// import '../models/notepad_response.dart';

// class NotepadService {
//   late InterceptorHttp interceptorHttp;

//   NotepadService() {
//     interceptorHttp = InterceptorHttp();
//   }
//   Future<GeneralResponse<NotepadResponse>> getGrades(BuildContext context,) async {
//     const String url = 'father/getNotes';

//     try {
//       GeneralResponse resp = await interceptorHttp.request(context, "GET", url, null);
//       NotepadResponse? gradesResponse;

//       if (!resp.error) {
//         gradesResponse = notepadResponseFromJson(json.encode(resp.data));
//       }

//       return GeneralResponse(message: resp.message, data: gradesResponse, error: resp.error);
//     } catch (e) {
//       GlobalHelper.logger.e('Error en el metodo getGrades $e');
//       return GeneralResponse(message: e.toString(), error: true);
//     }
//   }
// }
