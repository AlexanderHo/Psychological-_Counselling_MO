import 'dart:convert';
import 'dart:developer';

import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:astrology/resourse/profile/account.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'google_sign_in.dart';
import 'user_.dart';

Future<void> addProfile(
    String name,
    String date,
    String place,
    double latitude,
    double longitude,
    /*String profilePhoto,*/
    String gender,
    int userId) async {
  log(userId.toString());
  String bearer = await getIDToken();
  String url = 'https://psycteam.azurewebsites.net/api/Profiles/create';
  var response = await http.Client().post(Uri.parse(url),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + bearer,
      },
      body: json.encode({
        "name": name,
        "dob": date,
        "birthPlace": place,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        "gender": gender,
        // "status": "active",
        // 'profilePhoto': profilePhoto,
        "customerId": userId
      }));
  final a = response;
  log(a.statusCode.toString());
  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: "Thêm hồ sơ thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 108, 219, 113),
        textColor: Colors.black54,
        fontSize: 16.0);
    AppRouter.push(AccountPage());
  } else {
    Fluttertoast.showToast(
        msg: "Thêm hồ sơ thất bại",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade200,
        textColor: Colors.black54,
        fontSize: 16.0);
  }
}

Future<void> changePass(
  String oldPassword,
  String newPassword,
) async {
  int? id = CurrentUser.getUserId();
  // String bearer = await getIDToken();
  String url =
      'https://psycteam.azurewebsites.net/api/Users/changepassuserbycustomerid';
  var response = await http.put(Uri.parse(url),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json'
        // 'Authorization': 'Bearer ' + bearer,
      },
      body: json.encode({
        "id": '$id',
        "oldPassword": '$oldPassword',
        "newPassword": '$newPassword',
      }));
  final a = response;
  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: "Cập nhật thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 108, 219, 113),
        textColor: Colors.black54,
        fontSize: 16.0);
    AppRouter.push(AccountPage());
  } else {
    Fluttertoast.showToast(
        msg: "Cập nhật thất bại",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade200,
        textColor: Colors.black54,
        fontSize: 16.0);
  }
}

Future<void> updateProfile(
    int profileId,
    String name,
    // String date,
    String place,
    double latitude,
    double longitude,
    String gender,
    String profilePhoto) async {
  String? email = CurrentUser.getEmail();
  // String bearer = await getIDToken();
  String url = 'https://psycteam.azurewebsites.net/api/Customers/update';
  var response = await http.put(Uri.parse(url),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json'
        // 'Authorization': 'Bearer ' + bearer,
      },
      body: json.encode({
        "id": '$profileId',
        "fullname": '$name',
        'email': email,
        "address": '$place',
        "gender": '$gender',
        "longitude": '$longitude',
        "latitude": '$latitude',
        "imageUrl": '$profilePhoto',
      }));
  final a = response;
  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: "Cập nhật thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 108, 219, 113),
        textColor: Colors.black54,
        fontSize: 16.0);
    AppRouter.push(HomeScreen());
  } else {
    Fluttertoast.showToast(
        msg: "Cập nhật thất bại",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade200,
        textColor: Colors.black54,
        fontSize: 16.0);
  }
}
