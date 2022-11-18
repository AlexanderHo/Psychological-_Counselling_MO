import 'dart:convert';
import 'dart:developer';

import 'package:astrology/reponsitory/user_.dart';
import 'package:http/http.dart' as http;

Future<void> bookingSlot(
  int slotId,
  int consultantId,
  int customerId,
) async {
  // String bearer = await getIDToken();
  String url =
      'https://psycteam.azurewebsites.net/api/Bookings/create?slotid=${slotId}&customerid=${customerId}&consultantid=${consultantId}';
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
}
