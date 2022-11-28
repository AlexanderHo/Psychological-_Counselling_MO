import 'dart:convert';
import 'dart:developer';
import 'package:astrology/model/Consultant_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/ConsutantSpec_model.dart';

List<ConsultantModel> parseGeneralConsultantData(List responseBody) {
  return responseBody
      .map<ConsultantModel>((json) => ConsultantModel.fromGeneralJson(json))
      .toList();
}

//======================================================
// Future<String> getIDToken() async {
//   String name = "adminpsyc";
//   String pass = "admin1245";
//   var res = await http.Client().post(
//       Uri.parse(
//           'https://www.psychologicalcounselingv1.somee.com/api/FirebaseServices/loginadmin/'),
//       headers: <String, String>{
//         'accept': '*/*',
//         'Content-Type': 'application/json'
//       },
//       body: json.encode({
//         'userName': name,
//         'passWord': pass,
//       }));
//   final data = jsonDecode(res.body);
//   String token = data['jwttoken'];
//   print('token: ' + token);
//   return token;
// }

//======================================================
Future<List<ConsultantModel>> fetchGeneralConsultantData(
    http.Client client) async {
  // String bearer = await getIDToken();
  var response = await client.get(
    Uri.parse(
        'https://psycteam.azurewebsites.net/api/Consultants/Getallconsultant'),
    headers: <String, String>{
      'accept': '*/*',
      // 'Authorization': 'Bearer ' + bearer,
    },
  );
  // log(response.body);
  Map map = jsonDecode(response.body);
  return parseGeneralConsultantData(map['data']);
}

//========================================================
ConsultantModel parseConsultantDetailModel(Map<String, dynamic> responseBody) {
  return ConsultantModel.fromJson(responseBody);
}

//=======================================================
Future<ConsultantModel> fetchConsultantDetailData(int id) async {
  // String bearer = await getIDToken();
  var response = await http.Client().get(
    Uri.parse('https://psycteam.azurewebsites.net/api/Consultants/getbyid?id=' +
        id.toString()),
    headers: <String, String>{
      'accept': '*/*',
      // 'Authorization': 'Bearer ' + bearer,
    },
  );
  Map<String, dynamic> a = jsonDecode(response.body);
  print(response.body);
  log(response.statusCode.toString());
  if (response.statusCode == 200) {
    return parseConsultantDetailModel(a['data']);
  } else {
    throw Exception('Failed to load Consultant');
  }
}

//=================================================
List<ConsultantSpecModel> parseGeneralConsultantSpecData(List responseBody) {
  return responseBody
      .map<ConsultantSpecModel>(
          (json) => ConsultantSpecModel.fromGeneralJson(json))
      .toList();
}

//===========================================================
Future<List<ConsultantSpecModel>> fetchGeneralConsultantBySpecial(
    String spec) async {
  // String bearer = await getIDToken();
  var response = await http.get(
    Uri.parse(
        'https://psycteam.azurewebsites.net/api/Consultants/Getconsultantbyspecial?search=' +
            spec),
    headers: <String, String>{
      'accept': '*/*',
      // 'Authorization': 'Bearer ' + bearer,
    },
  );
  // log(response.body);
  Map map = jsonDecode(response.body);
  return parseGeneralConsultantSpecData(map['data']);
}
