import 'dart:convert';
import 'package:astrology/model/SurveyType_model.dart';
import 'package:http/http.dart' as http;

List<SurveysTypeModel> parseSurveyType(List response) {
  return response
      .map<SurveysTypeModel>((json) => new SurveysTypeModel.fromJson(json))
      .toList();
}

//============================
Future<List<SurveysTypeModel>> fetchSurveyType(http.Client client) async {
  var response = await http.Client().get(
      Uri.parse(
          'https://psycteam.azurewebsites.net/api/SurveyTypes/getallsurveytype'),
      headers: <String, String>{
        'accept': 'text/plain',
      });
  print(response.body);
  Map data = jsonDecode(response.body);
  print(data['data']);

  return parseSurveyType(data['data']);
}
