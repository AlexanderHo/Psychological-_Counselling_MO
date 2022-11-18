import 'dart:convert';
import 'dart:developer';
import 'package:astrology/model/Transaction_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List<TransactionModel> parseTransaction(List response) {
  return response
      .map<TransactionModel>((json) => new TransactionModel.fromJson(json))
      .toList();
}

//============================
Future<List<TransactionModel>> fetchTransaction() async {
  int id = CurrentUser.getUserId() ?? 0;
  var response = await http.get(
      Uri.parse(
          'https://psycteam.azurewebsites.net/api/Transactions/Getbookingtransbycustomerid?id=${id}'),
      headers: <String, String>{
        'accept': '*/*',
      });
  print(response.body);
  Map data = jsonDecode(response.body);
  print(data['data']);

  return parseTransaction(data['data']);
}
