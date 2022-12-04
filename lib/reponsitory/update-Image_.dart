import 'dart:convert';
import 'dart:io';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../resourse/profile/add&editProfile/edit_account.dart';

Future<void> loadImageCustomer(File file) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int? id = CurrentUser.getUserId();
  String? bearer = prefs.getString('Bearer');
  String? urlImage;

  try {
    var postUri = Uri.parse(
        "https://psycteamv2.azurewebsites.net/api/FirebaseServices/upload");
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
