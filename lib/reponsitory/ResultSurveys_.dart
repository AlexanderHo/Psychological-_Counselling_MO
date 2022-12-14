import 'dart:convert';
import 'dart:developer';
import 'package:astrology/model/ResultSurveys_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Result_model.dart';

ResultModel parseResultModels(Map<String, dynamic> responseBody) {
  return ResultModel.fromJson(responseBody);
}

Future<ResultModel> getResult(
  List<int> answer,
) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  int? id = pref.getInt("idcustomer");
  List<ansModel> result = [ansModel(id: id!, answer: answer)];
  var map = ansModel.getListMap(result);
  print(map);
  String url =
      'https://psycteamv2.azurewebsites.net/api/ResultSurveys/submitsurveybylist';
  var response = await http.Client().post(Uri.parse(url),
      headers: <String, String>{
        'accept': 'text/plain',
        'Content-Type': 'application/json'
      },
      body: json.encode(map[0]));
  Map<String, dynamic> a = jsonDecode(response.body);
  print(response.body);
  log(response.statusCode.toString());
  if (response.statusCode == 200) {
    return parseResultModels(a);
  } else {
    throw Exception('Failed to load deposit');
  }
}

//===================================
Result parseResult(Map<String, dynamic> responseBody) {
  return Result.fromJson(responseBody);
}

Future<Result> getResul(http.Client client) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  int? id = pref.getInt("idcustomer");
  String url =
      'https://psycteamv2.azurewebsites.net/api/ResultSurveys/getresultsurveyandbirthchart?customerid=' +
          id.toString();
  var response = await client.get(
    Uri.parse(url),
    headers: <String, String>{
      'accept': 'text/plain',
      'Content-Type': 'application/json'
    },
  );
  Map<String, dynamic> a = jsonDecode(response.body);
  print(response.body);
  log(response.statusCode.toString());
  if (response.statusCode == 200) {
    return parseResult(a);
  } else {
    throw Exception('Failed to load deposit');
  }
}
