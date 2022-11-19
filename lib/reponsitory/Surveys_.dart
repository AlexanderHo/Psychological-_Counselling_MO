import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:astrology/model/Survey_model.dart';

List<SurveysModel> parseSurvey(List response) {
  return response
      .map<SurveysModel>((json) => new SurveysModel.fromJson(json))
      .toList();
}

//============================
Future<List<SurveysModel>> fetchSurvey(int id) async {
  var response = await http.Client().get(
      Uri.parse(
          'https://psycteam.azurewebsites.net/api/Surveys/getsurveybysurveytypeid?surveytypeid=' +
              id.toString()),
      headers: <String, String>{
        'accept': 'text/plain',
      });
  print(response.body);
  Map data = jsonDecode(response.body);
  print(data['data']);

  return parseSurvey(data['data']);
}
