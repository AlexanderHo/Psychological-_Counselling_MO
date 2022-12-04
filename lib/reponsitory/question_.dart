import 'dart:convert';
import 'package:astrology/model/Question_model.dart';
import 'package:http/http.dart' as http;

List<QuestionModel> parseQuestion(List response) {
  return response
      .map<QuestionModel>((json) => new QuestionModel.fromJson(json))
      .toList();
}

//============================
Future<List<QuestionModel>> fetchQuestion(int surveyid) async {
  var response = await http.Client().get(
      Uri.parse(
          'https://psycteamv2.azurewebsites.net/api/Questions/getquestionbysurveyid?surveyid=${surveyid}'),
      headers: <String, String>{
        'accept': 'text/plain',
      });
  print(response.body);
  Map data = jsonDecode(response.body);
  print(data['data']);

  return parseQuestion(data['data']);
}
