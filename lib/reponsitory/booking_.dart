import 'dart:convert';
import 'dart:developer';

import 'package:astrology/reponsitory/user_.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/SlotBooking/Slot_Booking.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../resourse/app_router.dart';

Future<void> bookingSlot(
  int slotId,
  int consultantId,
  int customerId,
) async {
  // String bearer = await getIDToken();
  String url =
      'https://psycteamv2.azurewebsites.net/api/Bookings/create?slotid=${slotId}&customerid=${customerId}&consultantid=${consultantId}';
  var response = await http.Client().post(
    Uri.parse(url),
    headers: <String, String>{
      'accept': 'application/json',
      // 'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ' + bearer,
    },
  );
  final a = response;
  print(a.body);
  log(a.statusCode.toString());
  if (response.statusCode == 200) {
    print("run");
    Fluttertoast.showToast(
        msg: "Đặt Lịch thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 108, 219, 113),
        textColor: Colors.black54,
        fontSize: 16.0);
    AppRouter.push(SlotBookingPage(consultantId: consultantId));
  } else {
    Fluttertoast.showToast(
        msg: "Đặt Lịch thất bại",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade200,
        textColor: Colors.black54,
        fontSize: 16.0);
  }
}

Future<void> FeedBack(
  int bookingId,
  TextEditingController Feedback,
  int? rate,
) async {
// String bearer = await getIDToken();
  String url =
      'https://psycteamv2.azurewebsites.net/api/Bookings/feedbackbycustomer?id=${bookingId}&feedback=${Feedback.text}&rate=${rate}';
  var response = await http.Client().put(
    Uri.parse(url),
    headers: <String, String>{
      'accept': 'application/json',
    },
  );
  final a = json.decode(response.body);
  if (response.statusCode == 200) {
    print("canel run");
    AppRouter.out(HomeScreen());
    Fluttertoast.showToast(
        msg: "Feedback thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 108, 219, 113),
        textColor: Colors.black54,
        fontSize: 16.0);
  } else {
    Fluttertoast.showToast(
        msg: a['message'].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red.shade200,
        textColor: Colors.black54,
        fontSize: 16.0);
  }
}
