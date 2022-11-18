import 'dart:developer';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/notifi/notification.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/notification_model.dart';
import '../resourse/Schedule/schedule.dart';
import '../resourse/app_router.dart';

List<NotiModel> parsNotiModels(List responseBody) {
  print('đâ tới đây');
  print(responseBody);
  return responseBody
      .map<NotiModel>((json) => NotiModel.fromJson(json))
      .toList();
}

Future<List<NotiModel>> fetchNotiData(int id) async {
  // String bearer = await getIDToken();
  // log(bearer);

  var response = await http.Client().get(
    Uri.parse(
        'https://psycteam.azurewebsites.net/api/Notifications/getnotificationbycustomer?id=${id}'),
    headers: <String, String>{
      'accept': '*/*',
      // 'Authorization': 'Bearer ' + bearer,
    },
  );

  print(response.body);
  Map map = jsonDecode(response.body);
  print(map['data']);
  return parsNotiModels(map['data']);
}

Future<void> HiddenNoti(
  int id,
) async {
  int customerId = CurrentUser.getUserId() ?? 0;
  String url =
      'https://psycteam.azurewebsites.net/api/Notifications/hiddennoti?id=${id}';
  var response = await http.Client().put(
    Uri.parse(url),
    headers: <String, String>{
      'accept': '*/*',
      // 'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ' + bearer,
    },
  );
  if (response.statusCode == 200) {
    fetchNotiData(customerId);
    // AppRouter.push(notificationPage());
  }
  final a = response;
  log(a.statusCode.toString());
}

Future<void> SeenNoti(
  int id,
) async {
  int customerId = CurrentUser.getUserId() ?? 0;
  String url =
      'https://psycteam.azurewebsites.net/api/Notifications/seennoti?id=${id}';
  var response = await http.Client().put(
    Uri.parse(url),
    headers: <String, String>{
      'accept': '*/*',
      // 'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ' + bearer,
    },
  );
  // if (response.statusCode == 200) {
  //   fetchNotiData(customerId);
  //   AppRouter.push(notificationPage());
  // }
  final a = response;
  log(a.statusCode.toString());
}
