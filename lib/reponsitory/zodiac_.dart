import 'dart:developer';
import 'package:astrology/model/zodiac_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<ZodiacModel> parseGeneralZodiacModels(List responseBody) {
  // final parsed = jsonDecode(responseBody).cast<Map<String,dynamic>>();
  return responseBody
      .map<ZodiacModel>((json) => ZodiacModel.fromGeneralJson(json))
      .toList();
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

Future<List<ZodiacModel>> fetchGeneralZodiacData(http.Client client) async {
  String bearer = await getIDToken();
  var response = await http.Client().get(
    Uri.parse('https://psycteam.azurewebsites.net/api/Zodiacs/Getallzodiacs'),
    headers: <String, String>{
      'accept': '*/*',
      'Authorization': 'Bearer ' + bearer,
    },
  );
  print(response.body);
  Map map = jsonDecode(response.body);
  return parseGeneralZodiacModels(map['data']);
}

ZodiacModel parseZodiacDetailModels(Map<String, dynamic> responseBody) {
  // final parsed = jsonDecode(responseBody);
  return ZodiacModel.fromJson(responseBody);
}

Future<ZodiacModel> fetchZodiacDetailData(int id) async {
  String bearer = await getIDToken();
  var response = await http.get(
    Uri.parse('https://psycteam.azurewebsites.net/api/Zodiacs/getbyid?id=' +
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
    return parseZodiacDetailModels(map['data'][0]);
  } else {
    throw Exception('Failed to load zodiac');
  }
}
