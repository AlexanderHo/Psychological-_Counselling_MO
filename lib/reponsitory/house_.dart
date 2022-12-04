import 'dart:convert';
import 'dart:developer';

import 'package:astrology/model/house_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

List<HouseModel> parseGeneralHouseData(List responseBody) {
  return responseBody
      .map<HouseModel>((json) => HouseModel.fromGeneralJson(json))
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

Future<List<HouseModel>> fetchGeneralHouseData(http.Client client) async {
  String bearer = await getIDToken();
  var response = await client.get(
    Uri.parse('https://psycteamv2.azurewebsites.net/api/Houses/Getallhouses'),
    headers: <String, String>{
      'accept': '*/*',
      'Authorization': 'Bearer ' + bearer,
    },
  );
  Map map = jsonDecode(response.body);
  return parseGeneralHouseData(map['data']);
}

HouseModel parseHouseDetailModels(Map<String, dynamic> responseBody) {
  // final parsed = jsonDecode(responseBody);
  return HouseModel.fromJson(responseBody);
}

Future<HouseModel> fetchHouseDetailData(int id) async {
  String bearer = await getIDToken();
  var response = await http.get(
    Uri.parse('https://psycteamv2.azurewebsites.net/api/Houses/getbyid?id=' +
        id.toString()),
    headers: <String, String>{
      'accept': '*/*',
      'Authorization': 'Bearer ' + bearer,
    },
  );
  log(response.body);
  var jsonString = jsonDecode(response.body);
  Map<String, dynamic> map = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return parseHouseDetailModels(map['data'][0]);
  } else {
    throw Exception('Failed to load planet');
  }
}
