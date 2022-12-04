import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:astrology/model/Daily_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';

DailyModel parseDailyModels(Map<String, dynamic> responseBody) {
  // final parsed = jsonDecode(responseBody);
  return DailyModel.fromJson(responseBody);
}

Future<DailyModel> fetchDailyData(String date) async {
  int? id = CurrentUser.getZodiacId() ?? 0;
  String bearer = await getIDToken();
  var response = await http.get(
    Uri.parse(
        'https://psycteamv2.azurewebsites.net/api/DailyHoroscopes/Getalldailyhoroscopes?id=${id}&date=${date}'),
    headers: <String, String>{
      'accept': '*/*',
      'Authorization': 'Bearer ' + bearer,
    },
  );
  var jsonString = jsonDecode(response.body);
  Map<String, dynamic> map = jsonDecode(response.body);
  log(response.body);
  if (response.statusCode == 200) {
    return parseDailyModels(map['data'][0]);
  } else {
    throw Exception('Failed to load planet');
  }
}

Future<String> getIDToken() async {
  String name = "adminpsyc";
  String pass = "admin1245";
  var res = await http.Client().post(
      Uri.parse(
          'https://psycteamv2.azurewebsites.net/api/FirebaseServices/loginadmin'),
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
