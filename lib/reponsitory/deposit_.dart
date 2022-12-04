import 'dart:convert';
import 'dart:developer';
import 'package:astrology/model/Deposit_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

DepositModel parseDepositModels(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return DepositModel.fromJson(parsed);
}

Future<DepositModel> getDeposit(
  TextEditingController amount,
) async {
  // String bearer = await getIDToken();
  int id = CurrentUser.getUserId() ?? 0;
  print(amount.text);
  String url =
      'https://psycteamv2.azurewebsites.net/api/Deposits/create?customerid=${id}&amount=${amount.text}';
  var response = await http.Client().post(
    Uri.parse(url),
    headers: <String, String>{
      'accept': 'accept: text/plain',
      // 'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ' + bearer,
    },
  );
  final a = response;
  print(a.body);
  print(a);
  log(a.statusCode.toString());
  if (response.statusCode == 200) {
    return compute(parseDepositModels, response.body);
  } else {
    throw Exception('Failed to load deposit');
  }
}
