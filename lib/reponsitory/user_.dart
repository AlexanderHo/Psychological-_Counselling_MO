import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/new_user_model.dart';
import '../model/user.dart';
import 'current_user_shared_preferences.dart';
import 'google_sign_in.dart';

UserModel parseUserModel(Map<String, dynamic> responseBody) {
  return UserModel.fromJson(responseBody);
}

List<Profile> parseListProfile(List responseBody) {
  return responseBody
      .map<Profile>((json) => new Profile.fromJson(json))
      .toList();
}

Future<List<Profile>> fetchListProfile() async {
  String bearer = await getIDToken();
  int? id = CurrentUser.getUserId() ?? 0;
  var response = await http.get(
    Uri.parse(
        'https://psycteam.azurewebsites.net/api/Profiles/getbyidcustomer?id=' +
            id.toString()),
    headers: <String, String>{
      'accept': '*/*',
      'Authorization': 'Bearer ' + bearer,
    },
  );
  final list = jsonDecode(response.body);
  return parseListProfile(list['data']);
}

NewUserModel parseNewUserModel(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return NewUserModel.fromJson(parsed);
}

Future<String> getIDToken() async {
  String name = "adminpsyc";
  String pass = "admin1245";
  var res = await http.Client().post(
      Uri.parse(
          'https://psycteam.azurewebsites.net/api/FirebaseServices/loginadmin'),
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

Future<String> matching(int profileId) async {
  var pref = await SharedPreferences.getInstance();
  int? id = CurrentUser.getUserId() ?? 0;
  var res = await http.Client().get(
      Uri.parse(
          'https://psycteam.azurewebsites.net/api/Profiles/lovecompatibility?customerid=${id}&profileid=${profileId}'),
      headers: <String, String>{
        'accept': '*/*',
      });

  final data = json.decode(res.body);
  print(data);
  print(data['data']);
  pref.setString("matching", data['data']);
  return data['data'];
}

getMatch() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? macth = pref.getString("matching");
  return macth;
}
