import 'dart:convert';
import 'package:astrology/model/Specializations_model.dart';
import 'package:http/http.dart' as http;

List<SpeciaModel> parseSpec(List response) {
  return response
      .map<SpeciaModel>((json) => new SpeciaModel.fromJson(json))
      .toList();
}

//============================
Future<List<SpeciaModel>> fetchSpec(int id) async {
  var response = await http.get(
      Uri.parse(
          'https://psycteamv2.azurewebsites.net/api/Specializations/getbyconsultantid?id=' +
              id.toString()),
      headers: <String, String>{
        'accept': '*/*',
      });
  print(response.body);
  Map data = jsonDecode(response.body);
  print(data['data']);

  return parseSpec(data['data']);
}
