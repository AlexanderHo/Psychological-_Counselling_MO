import 'dart:developer';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/wallet_model.dart';

WalletModel parseWallet(String responseBody) {
  print('tới đay nè');
  print(responseBody);
  final parsed = jsonDecode(responseBody);
  print(parsed['data'][0]);
  return WalletModel.fromJson(parsed['data'][0]);
}

Future<WalletModel> fetchWallet() async {
  int customerId = CurrentUser.getUserId() ?? 0;
  // String bearer = await getIDToken();
  var response = await http.get(
    Uri.parse(
        'https://psycteamv2.azurewebsites.net/api/Wallets/getbycustomerid?id=' +
            customerId.toString()),
    headers: <String, String>{
      'accept': '*/*',
      // 'Authorization': 'Bearer ' + bearer,
    },
  );
  log(response.body);
  if (response.statusCode == 200) {
    return compute(parseWallet, response.body);
  } else {
    throw Exception('Failed to load planet');
  }
}
