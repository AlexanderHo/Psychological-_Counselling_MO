import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/Astrologer/Astrologer.dart';
import 'package:astrology/resourse/Live/live.dart';
import 'package:astrology/resourse/Surveys/Survey.dart';
import 'package:astrology/resourse/Surveys/SurveyType.dart';
import 'package:astrology/resourse/Wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/Schedule/schedule.dart';
import 'package:astrology/resourse/Call/call.dart';
import 'package:astrology/resourse/Chat/chat.dart';

class HistoryBar extends StatelessWidget {
  String selected = "";
  Color colorSelected = Color(0xFFff7010);
  Color colorNormal = Colors.white;
  HistoryBar({required this.selected});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (selected == "Appoitment")
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AppointmentPage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/home.png",
                    color: colorSelected,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Appoitment",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
            )
          else
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AppointmentPage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/home.png",
                    color: colorNormal,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Appoitment",
                    style: TextStyle(fontSize: 12, color: Colors.white60),
                  )
                ],
              ),
            ),
          //=============================================================APPOINTMENT
          if (selected == "History")
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SurveyTypePage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/chat.png",
                    color: colorSelected,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "History",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
            )
          else
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SurveyTypePage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/chat.png",
                    color: colorNormal,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "History",
                    style: TextStyle(fontSize: 12, color: Colors.white60),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
