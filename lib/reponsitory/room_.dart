import 'dart:convert';
import 'dart:developer';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:astrology/model/RoomVideo_model.dart';
import 'package:astrology/resourse/Call/Components/CallBody.dart';
import 'package:astrology/resourse/Live/Component/liveView.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

RoomModel parseRoom(Map<String, dynamic> responseBody) {
  return RoomModel.fromJson(responseBody);
}
//=================================================

Future<RoomModel> fetchRoom(int id, int bookingId) async {
  var response = await http.get(
      Uri.parse(
          'https://psycteam.azurewebsites.net/api/SlotBookings/getroomslotbooking?id=${id}'),
      headers: <String, String>{
        'accept': '*/*',
      });

  Map data = jsonDecode(response.body);
  print(data['data'][0]['chanelName']);
  Onjoin(data['data'][0]['chanelName'], ClientRole.Broadcaster,
      data['data'][0]['token'], bookingId);
  return parseRoom(data['data'][0]);
}

//====================================================

Future<void> Onjoin(
  String? chanelName,
  ClientRole? role,
  String? token,
  int bookingId,
) async {
  await _handleCameraandMic(Permission.camera);
  await _handleCameraandMic(Permission.microphone);
  await AppRouter.push(
    BodyCall(
      chanelName: chanelName,
      role: role,
      token: token,
      bookingId: bookingId,
    ),
  );
}

//=======================================================
Future<void> _handleCameraandMic(Permission permission) async {
  final status = await permission.request();
  log(status.toString());
}

//========================================================
Future<RoomModel> fetchLiveStream(int id) async {
  var response = await http.get(
      Uri.parse(
          'https://psycteam.azurewebsites.net/api/SlotBookings/getroomslotbooking?id=${id}'),
      headers: <String, String>{
        'accept': '*/*',
      });

  Map data = jsonDecode(response.body);
  print(data['data'][0]['chanelName']);
  OnJoinLive(data['data'][0]['chanelName'], ClientRole.Audience,
      data['data'][0]['token']);
  return parseRoom(data['data'][0]);
}

//=========================================================
Future<void> OnJoinLive(
  String? chanelName,
  ClientRole? role,
  String? token,
) async {
  await _handleCameraandMic(Permission.camera);
  await _handleCameraandMic(Permission.microphone);
  await AppRouter.push(
    BodyLive(
      chanelName: chanelName,
      role: role,
      token: token,
    ),
  );
}
