import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/news_model.dart';

List<NewsModel> parseNewsData(List responseBody) {
  return responseBody
      .map<NewsModel>((json) => NewsModel.fromGeneralJson(json))
      .toList();
}

Future<List<NewsModel>> fetchNewsData(http.Client client) async {
  String bearer = await getIDToken();
  var response = await client.get(
    Uri.parse(
        'https://psycteam.azurewebsites.net/api/Articles/getarticlescustomer'),
    headers: <String, String>{
      'accept': '*/*',
      'Authorization': 'Bearer ' + bearer,
    },
  );
  Map map = jsonDecode(response.body);
  return parseNewsData(map['data']);
}

Future<String> getIDToken() async {
  String name = "adminpsyc";
  String pass = "admin1245";
  var res = await http.Client().post(
      Uri.parse(
          'https://psycteam.azurewebsites.net/api/FirebaseServices/loginadmin/'),
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

NewsModel parseNewDetailModels(Map<String, dynamic> responseBody) {
  // final parsed = jsonDecode(responseBody);
  return NewsModel.fromJson(responseBody);
}

Future<NewsModel> fetchNewDetailData(int id) async {
  String bearer = await getIDToken();
  var response = await http.get(
    Uri.parse('https://psycteam.azurewebsites.net/api/Articles/getbyid?id=' +
        id.toString()),
    headers: <String, String>{
      'accept': '*/*',
      'Authorization': 'Bearer ' + bearer,
    },
  );
  var jsonString = jsonDecode(response.body);
  Map<String, dynamic> map = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return parseNewDetailModels(map['data'][0]);
  } else {
    throw Exception('Failed to load planet');
  }
}
