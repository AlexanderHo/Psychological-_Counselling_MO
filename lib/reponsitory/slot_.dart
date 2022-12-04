import 'dart:convert';
import 'dart:developer';
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

List<SlotModel> parseSlot(List response) {
  return response.map<SlotModel>((json) => SlotModel.fromJson(json)).toList();
}

//============================
Future<List<SlotModel>> fetchSlot(int id, String date) async {
  var response = await http.get(
      Uri.parse(
          'https://psycteamv2.azurewebsites.net/api/SlotBookings/GetSlotBookingByDateAndConsultanid?date=${date}&consultantid=${id}'),
      headers: <String, String>{
        'accept': '*/*',
      });
  print(response.body);
  Map data = jsonDecode(response.body);
  print(data['data']);

  return parseSlot(data['data']);
}

//===============================================
Future<List<SlotModel>> fetchSlotApm(int id, String date) async {
  var response = await http.get(
      Uri.parse(
          'https://psycteamv2.azurewebsites.net/api/SlotBookings/GetAppointmentByCustomerid?date=${date}&customerid=${id}'),
      headers: <String, String>{
        'accept': '*/*',
      });
  Map data = jsonDecode(response.body);
  print(data);
  return parseSlot(data['data']);
}

//============================================================
Future<void> CancelBooking(
  TextEditingController reason,
  int idSlot,
  String dateSlot,
) async {
  int customerId = CurrentUser.getUserId() ?? 0;
  String url =
      'https://psycteamv2.azurewebsites.net/api/SlotBookings/cancelbycustomer?id=${idSlot}&reason=${reason.text}';
  var response = await http.Client().put(
    Uri.parse(url),
    headers: <String, String>{
      'accept': '*/*',
      // 'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ' + bearer,
    },
  );
  print(reason);
  print("Cacel booking run");
  print(response.statusCode);
  if (response.statusCode == 200) {
    print("canel run");
    fetchSlotApm(customerId, dateSlot);
    AppRouter.push(AppointmentPage());
    Fluttertoast.showToast(
        msg: "Hủy thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 108, 219, 113),
        textColor: Colors.black54,
        fontSize: 16.0);
  } else {
    Fluttertoast.showToast(
        msg: "Hủy thất bại",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade200,
        textColor: Colors.black54,
        fontSize: 16.0);
  }
}

//========================================================
Future<List<SlotModel>> fetchStream() async {
  DateTime? date = DateTime.now();
  DateFormat formatDate = DateFormat('yyyy-MM-dd');
  var response = await http.get(
      Uri.parse(
          'https://psycteamv2.azurewebsites.net/api/SlotBookings/GetSlotLiveStreamByDateAndConsultanid?date=${formatDate.format(date)}'),
      headers: <String, String>{
        'accept': '*/*',
      });
  print(response.body);
  Map data = jsonDecode(response.body);
  print(data['data']);

  return parseSlot(data['data']);
}

//======================================
Future<List<SlotModel>> fetchSlotHis(int id, String date) async {
  var response = await http.get(
      Uri.parse(
          'https://psycteamv2.azurewebsites.net/api/SlotBookings/GetHistoryByCustomerid?date=${date}&customerid=${id}'),
      headers: <String, String>{
        'accept': '*/*',
      });
  Map data = jsonDecode(response.body);
  print(data);
  return parseSlot(data['data']);
}
