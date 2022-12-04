import 'dart:convert';
import 'package:astrology/model/optionQuestion_model.dart';
import 'package:http/http.dart' as http;

List<OptionModel> parseOption(List response) {
  return response
      .map<OptionModel>((json) => new OptionModel.fromJson(json))
      .toList();
}

//============================
Future<List<OptionModel>> fetchOption(int surveyid) async {
  var response = await http.Client().get(
      Uri.parse(
          'https://psycteamv2.azurewebsites.net/api/OptionQuestions/getoptionbyquestionid?questionid=${surveyid}'),
      headers: <String, String>{
        'accept': '*/*',
      });
  print(response.body);
  Map data = jsonDecode(response.body);
  print(data['data']);

  return parseOption(data['data']);
}
//===============================================
