import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:astrology/reponsitory/geolocator_service.dart';
import 'package:astrology/reponsitory/user_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../model/new_user_model.dart';
import '../model/province.dart';
import '../model/user.dart';
import 'province_service.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<String> getIDToken() async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken(false);
    return token;
  }

  Future<http.Response> postRequest() async {
    // print('--------------------------Run--------------------------------');
    String idToken = await getIDToken();
    // log(idToken);
    var response = await http.Client().post(
      Uri.parse(
          'https://www.psychologicalcounselingv1.somee.com/api/FirebaseServices/logincustomer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': idToken,
      }),
    );
    // print('--------------------------------------------------------------');
    if (response.statusCode == 200) {
      log('id token successful');
    } else {
      log('id token failed');
    }
    return response;
  }

  // Future<UserModel> getCurrentUser() async {
  //   final headerResponse = await postRequest();
  //   String header = headerResponse.body;
  //   log(header);
  //   var response = await http.get(
  //       Uri.parse(
  //           'http://www.psychologicalcounselingv1.somee.com/api/Customers'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer ' + header,
  //       });
  //   return parseUserModel(response.body);
  // }

  Future<NewUserModel> getNewCurrentUser() async {
    final headerResponse = await postRequest();
    String header = headerResponse.body;
    log(header);
    var response = await http.get(
        Uri.parse(
            'http://www.psychologicalcounselingv1.somee.com/api/Users/createcustomer'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + header,
        });
    return parseNewUserModel(response.body);
  }

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    // final response = await getCurrentUser();

    notifyListeners(); //update UI
  }

  void signUp(String email, String password, Profile profile) async {
    try {
      // UserCredential userCredential=await auth.createUserWithEmailAndPassword(email: email, password: password);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // Map<String, Object> additionalClaims = new HashMap<String, Object>();
      // additionalClaims['name']=nameController.text;
      // additionalClaims['birthDate']=formatDate.format(birthDate!)+'T'+'${timeOfDay!.hour.toString().padLeft(2, '0')}:${timeOfDay!.minute.toString().padLeft(2, '0')}';
      // additionalClaims['birthPlace']=selectedProvince!;
      // additionalClaims['latitude']=latitude!;
      // additionalClaims['longtitude']=longitude!;
      // additionalClaims['gender']=genderController.selectedIndex == 0 ? true: false;
      NewUserModel newUserModel = await getNewCurrentUser();
      profile.setUserId(newUserModel.id);
      // logout();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Mật khẩu được cung cấp quá yếu.');
      } else if (e.code == 'email-already-in-use') {
        print('Tài khoản đã tồn tại cho email đó.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
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
