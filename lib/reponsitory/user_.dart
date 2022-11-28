import 'dart:convert';
import 'dart:developer';
import 'package:astrology/model/Match_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

MatchModel parseMatchModels(Map<String, dynamic> responseBody) {
  // final parsed = jsonDecode(responseBody);
  return MatchModel.fromJson(responseBody);
}

Future<MatchModel> matching(int profileId) async {
  var pref = await SharedPreferences.getInstance();
  int? id = CurrentUser.getUserId() ?? 0;
  var res = await http.Client().get(
      Uri.parse(
          'https://psycteam.azurewebsites.net/api/Profiles/lovecompatibility?customerid=${id}&profileid=${profileId}'),
      headers: <String, String>{
        'accept': '*/*',
      });

  Map<String, dynamic> map = jsonDecode(res.body);
  log(res.body);
  if (res.statusCode == 200) {
    return parseMatchModels(map);
  } else {
    throw Exception('Failed to load Matching');
  }
}

getMatch() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? macth = pref.getString("matching");
  return macth;
}

Future<void> addRegister(
    // TextEditingController
    emailController,
    fullnameController,
    usernameController,
    passwordController,
    String addressController,
    String gender,
    String dobController,
    phoneController,
    String? avatarURL,
    double? latitude,
    double? longitude) async {
  String bearer = await getIDToken();
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // String email = emailController.text;
  // prefs.setString('emailConsultant', email);
  // final String? token = prefs.getString('token');
  // String? token = prefs.getString('token');
  try {
    String body = json.encode({
      'userName': usernameController.text,
      'passWord': passwordController.text,
      'email': emailController.text,
    });
    String body2 = json.encode({
      'email': emailController.text,
      'fullName': fullnameController.text,
      'address': addressController,
      'dob': dobController,
      'gender': gender,
      'phone': phoneController.text,
      'imageUrl': avatarURL,
      'longitude': longitude.toString(),
      'latitude': latitude.toString(),
    });
    print(body);
    final response = await http.post(
        Uri.parse(
            "https://psycteam.azurewebsites.net/api/Users/createcustomerv2"),
        body: body,
        headers: {'accept': 'text/plain', 'content-type': 'application/json'});

    final response2 = await http.put(
        Uri.parse("https://psycteam.azurewebsites.net/api/Customers/update"),
        body: body2,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + bearer,
          'accept': '*/*',
        });
    print("api len");
    print(response.body);
    // print(response.statusCode);
    print(response2.body);
    // print(response2.statusCode);
    print("api 2 len");
    if (response.statusCode == 200 && response2.statusCode == 200) {
      print("regis success");
      // Get.to(VerifyEmailScreen());
      Fluttertoast.showToast(
          msg: "Code đã được gửi vào mail của bạn",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 44, 194, 6),
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      print("fail regis");
      Fluttertoast.showToast(
          msg: 'Email hoặc tên đăng nhập đã có. Vui lòng đk khác',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red.shade200,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  } catch (error) {
    print(error);
  }
}
