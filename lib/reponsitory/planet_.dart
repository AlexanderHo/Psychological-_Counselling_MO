import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/planet_model.dart';

List<PlanetModel> parseGeneralPlanetModels(List responseBody) {
  // final parsed = jsonDecode(responseBody).cast<Map<String,dynamic>>();
  return responseBody
      .map<PlanetModel>((json) => PlanetModel.fromGeneralJson(json))
      .toList();
}

Future<String> getIDToken() async {
  String name = "adminpsyc";
  String pass = "admin1245";
  var res = await http.Client().post(
      Uri.parse(
          'https://psycteamv2.azurewebsites.net/api/FirebaseServices/loginadmin/'),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'userName': name,
        'passWord': pass,
      }));
  final data = jsonDecode(res.body);
  String token = data['jwttoken'];
  print('token: ' + token);
  return token;
}

Future<List<PlanetModel>> fetchGeneralPlanetData(http.Client client) async {
  String bearer = await getIDToken();
  var response = await http.Client().get(
    Uri.parse('https://psycteamv2.azurewebsites.net/api/Planets/Getallplanets'),
    headers: <String, String>{
      'accept': '*/*',
      'Authorization': 'Bearer ' + bearer,
    },
  );
  print(response.body);
  Map map = jsonDecode(response.body);
  return parseGeneralPlanetModels(map['data']);
}

PlanetModel parsePlanetDetailModels(Map<String, dynamic> responseBody) {
  // final parsed = jsonDecode(responseBody);
  return PlanetModel.fromJson(responseBody);
}

Future<PlanetModel> fetchPlanetDetailData(int id) async {
  String bearer = await getIDToken();
  var response = await http.get(
    Uri.parse('https://psycteamv2.azurewebsites.net/api/Planets/getbyid?id=' +
        id.toString()),
    headers: <String, String>{
      'accept': '*/*',
      'Authorization': 'Bearer ' + bearer,
    },
  );
  var jsonString = jsonDecode(response.body);
  Map<String, dynamic> map = jsonDecode(response.body);
  log(response.body);
  if (response.statusCode == 200) {
    return parsePlanetDetailModels(map['data'][0]);
  } else {
    throw Exception('Failed to load planet');
  }
}
