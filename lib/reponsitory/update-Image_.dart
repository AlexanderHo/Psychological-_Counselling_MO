import 'dart:convert';
import 'dart:io';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../resourse/profile/add&editProfile/edit_account.dart';

Future<void> loadImageCustomer(File file) async {
  int? id = CurrentUser.getUserId();
  String bearer = await getIDToken();
  String? urlImage;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    var postUri = Uri.parse(
        "https://psycteam.azurewebsites.net/api/FirebaseServices/upload");
    http.MultipartRequest request = http.MultipartRequest("POST", postUri);
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'file',
      file.path,
    );
    request.headers.addAll({"Authorization": "Bearer $bearer"});
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    final request1 = await http.Response.fromStream(response);
    var reusult = request1.body;
    if (response.statusCode == 200) {
      print("update success");
      var jsonString = json.decode(reusult);
      urlImage = jsonString['data'];
      print(urlImage);
      await prefs.setString('imageUrl', urlImage!);
      AppRouter.push(EditAccountPage());
    }
  } catch (error) {
    print("lỗi rồi ");
  }
}

// Future<String> getUrl() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   String? urlImage = pref.getString('urlImage');
//   return urlImage!;
// }

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
