import 'dart:convert';
import 'dart:developer';
import 'package:astrology/model/History.dart';
import 'package:astrology/model/Slot_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/Schedule/schedule.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

HistoryModel parseHistoryDetailModels(responseBody) {
  final parsed = jsonDecode(responseBody);
  return HistoryModel.fromJson(parsed);
}

//==========================================
Future<HistoryModel> fetchHistory(int id) async {
  var response = await http.get(
      Uri.parse('https://psycteam.azurewebsites.net/api/SlotBookings/' +
          id.toString()),
      headers: <String, String>{
        'accept': '*/*',
      });
  // Map data = jsonDecode(response.body);
  // print(data);
  return parseHistoryDetailModels(response.body);
}
