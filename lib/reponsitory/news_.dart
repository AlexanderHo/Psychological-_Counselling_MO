import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/news_model.dart';

List<NewsModel> parseNewsData(List responseBody) {
  return responseBody
      .map<NewsModel>((json) => NewsModel.fromJson(json))
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
  return parseNewsData(map['payload']);
}

Future<String> getIDToken() async {
  String name = "adminpsyc";
  String pass = "admin1245";
  var res = await http.Client().post(
      Uri.parse(
          'https://www.psychologicalcounselingv1.somee.com/api/FirebaseServices/loginadmin/'),
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
