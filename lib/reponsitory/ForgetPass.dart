import 'dart:convert';
import 'dart:developer';

import 'package:astrology/resourse/ChangePass/NewPass.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/Login&register/login.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<void> ForgetPass(String userName) async {
  var response = await http.post(
    Uri.parse(
        'https://psycteam.azurewebsites.net/api/register/resendbyusername?username=' +
            userName),
    headers: <String, String>{
      'accept': '*/*',
    },
  );
  log(response.toString());
  if (response.statusCode == 200) {
    return AppRouter.push(NewPassPage(userName: userName));
  } else {
    Fluttertoast.showToast(
        msg: "Bạn bị sai tên Đăng nhập",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade200,
        textColor: Colors.black54,
        fontSize: 16.0);
  }
}

//========================================================
Future<void> NewPass(String userName, String pass, String code) async {
  String url =
      'https://psycteam.azurewebsites.net/api/register/changepassbyusername';
  var response = await http.put(Uri.parse(url),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json'
        // 'Authorization': 'Bearer ' + bearer,
      },
      body: json.encode({
        "userName": '$userName',
        "passWord": '$pass',
        "code": '$code',
      }));
  final a = json.decode(response.body);
  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: "Cập nhật thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 108, 219, 113),
        textColor: Colors.black54,
        fontSize: 16.0);
    AppRouter.push(LoginPage());
  } else {
    Fluttertoast.showToast(
        msg: a['message'].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade200,
        textColor: Colors.black54,
        fontSize: 16.0);
  }
}
