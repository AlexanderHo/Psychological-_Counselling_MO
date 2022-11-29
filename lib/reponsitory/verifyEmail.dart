import 'dart:convert';
import 'package:astrology/resourse/Login&register/login.dart';
import 'package:astrology/resourse/Surveys/SurveyType.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VerifyEmailController {
  Future<void> verifyEmail(TextEditingController num1Controller, num2Controller,
      num3Controller, num4Controller, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? email = prefs.getString('emailConsultant');
    // final String? token = prefs.getString('token');
    String numController = num1Controller.text +
        num2Controller.text +
        num3Controller.text +
        num4Controller.text;
    String? token = prefs.getString('token');
    try {
      String body = json.encode({'email': email, 'code': numController});

      print(body);
      final response = await http.put(
          Uri.parse("https://psycteam.azurewebsites.net/api/register/confirm"),
          body: body,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });

      print("api len");
      print(response.statusCode);

      print("api 2 len");
      if (response.statusCode == 200) {
        print("regis success");
        AppRouter.push(LoginPage());
        Fluttertoast.showToast(
            msg: "Xác thực thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 21, 170, 28),
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        print("fail regis");
        Fluttertoast.showToast(
            msg: "xác thực thất bại",
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
}
