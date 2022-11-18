import 'dart:convert';
import 'dart:developer';
import 'package:astrology/model/ResultSurveys_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../model/Result_model.dart';

ResultModel parseResultModels(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return ResultModel.fromJson(parsed);
}

Future<ResultModel> getResult(
  List<int> answer,
) async {
  // String bearer = await getIDToken();
  int id = CurrentUser.getUserId() ?? 0;
  List<ansModel> result = [ansModel(id: id, answer: answer)];
  var map = ansModel.getListMap(result);
  print(map);
  String url =
      'https://psycteam.azurewebsites.net/api/ResultSurveys/submitsurveybylist';
  var response = await http.Client().post(Uri.parse(url),
      headers: <String, String>{
        'accept': 'text/plain',
        'Content-Type': 'application/json'
      },
      body: json.encode(map[0]));
  final a = response;
  print(a.body);
  print(a);
  log(a.statusCode.toString());
  if (response.statusCode == 200) {
    return compute(parseResultModels, response.body);
  } else {
    throw Exception('Failed to load deposit');
  }
}
