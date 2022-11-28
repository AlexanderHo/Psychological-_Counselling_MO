import 'dart:developer';

import 'package:astrology/model/province.dart';
import 'package:astrology/model/user.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/reponsitory/geolocator_service.dart';
import 'package:astrology/reponsitory/province_service.dart';
import 'package:astrology/reponsitory/user_.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/Login&register/login.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends ChangeNotifier {
  String? token;
  String tokenDevice = "";

  Future<void> setTokenDevice(String token) async {
    tokenDevice = token;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tokenDevice', tokenDevice);
    print(tokenDevice);
  }

  login(String userName, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenDevice = prefs.getString('tokenDevice');
    var res = await http.Client().post(
        Uri.parse(
            'https://psycteam.azurewebsites.net/api/FirebaseServices/loginapp'),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "userName": '$userName',
          "passWord": '$password',
          'fcmToken': tokenDevice,
        }));
    print(tokenDevice);
    final data = json.decode(res.body);

    if (data['message'] == "Login with role customer successful") {
      prefs.setInt("idcustomer", data['idcustomer']);
      return AppRouter.push(HomeScreen());
    } else {
      print("fail login");
      Fluttertoast.showToast(
          msg: "login fail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red.shade200,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

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

  Future<UserModel> getCurrentUser() async {
    // String bearer = await getIDToken();
    int? id = await AuthRepo.getId();
    var response = await http.get(
      Uri.parse('https://psycteam.azurewebsites.net/api/Customers/getbyid?id=' +
          id.toString()),
      headers: <String, String>{
        'accept': '*/*',
        // 'Authorization': 'Bearer ' + bearer,
      },
    );
    var jsonString = jsonDecode(response.body);
    // Map<String, dynamic> map = {
    //   'fulname': jsonString['data'][0]['fullname']
    // };
    Map<String, dynamic> map = jsonDecode(response.body);
    print(map['data'][0]);
    return parseUserModel(map['data'][0]);
  }

  static getId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getInt("idcustomer");
    return id;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    AppRouter.pushAndRemove(LoginPage());
  }

  final geoLocationService = GeolocatorService();
  final provinceService = ProvinceService();
  //variable
  Position? currentLocation;
  List<Province>? provinces;
  ApplicationBloc() {
    getAllProvince();
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocationService.getCurrentLocation();
    notifyListeners();
  }

  getAllProvince() async {
    provinces = await provinceService.getAllProvince();
    notifyListeners();
  }
}
