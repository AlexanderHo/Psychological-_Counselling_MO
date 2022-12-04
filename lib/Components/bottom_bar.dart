import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/Astrologer/Astrologer.dart';
import 'package:astrology/resourse/Live/live.dart';
import 'package:astrology/resourse/Schedule/History.dart';
import 'package:astrology/resourse/Surveys/Survey.dart';
import 'package:astrology/resourse/Surveys/SurveyType.dart';
import 'package:astrology/resourse/Wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/Schedule/schedule.dart';
import 'package:astrology/resourse/Call/call.dart';

class BottomBar extends StatelessWidget {
  String selected = "";
  Color colorSelected = Color(0xFFff7010);
  Color colorNormal = Colors.white;
  BottomBar({required this.selected});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (selected == "home")
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
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
                    "Home",
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
                    return HomeScreen();
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
                    "Home",
                    style: TextStyle(fontSize: 12, color: Colors.white60),
                  )
                ],
              ),
            ),

          //=============================================================chuyen gia
          if (selected == "Consultant")
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AstrologerPage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/consul_icon.png",
                    color: colorSelected,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Chuyên gia",
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
                    return AstrologerPage();
                    ;
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/consul_icon.png",
                    color: colorNormal,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Chuyên gia",
                    style: TextStyle(fontSize: 12, color: Colors.white60),
                  )
                ],
              ),
            ),
          // //=============================================================TREATMENT
          // if(selected == "treatment")
          //   IconButton(
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(
          //         builder: (context) {
          //           return MainScreen();
          //         },
          //       ));
          //     },
          //     icon: Image.asset("assets/icons/treatment.png",color: colorSelected,),
          //     iconSize: size.width * 0.09,
          //   )
          // else
          //   IconButton(
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(
          //         builder: (context) {
          //           return MainScreen();
          //         },
          //       ));
          //     },
          //     icon: Image.asset("assets/icons/treatment.png", color: colorNormal,),
          //     iconSize: size.width * 0.09,
          //   )
          // ,
          //=============================================================
          if (selected == "Live")
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LivePage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/live.png",
                    color: colorSelected,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Live",
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
                    return LivePage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/live.png",
                    color: colorNormal,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Live",
                    style: TextStyle(fontSize: 12, color: Colors.white60),
                  ),
                ],
              ),
            ),
          //=============================================================APPOINTMENT
          if (selected == "History")
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return HistoryPage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/history-icon.png",
                    color: colorSelected,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Lịch sử",
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
                    return HistoryPage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/history-icon.png",
                    color: colorNormal,
                    width: size.width * 0.088,
                  ),
                  Text(
                    "Lịch sử",
                    style: TextStyle(fontSize: 12, color: Colors.white60),
                  )
                ],
              ),
            ),
          //====================================================================
          if (selected == "schedule")
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
                    "assets/icon/appointment.png",
                    color: colorSelected,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Cuộc hẹn",
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
                    "assets/icon/appointment.png",
                    color: colorNormal,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Cuộc hẹn",
                    style: TextStyle(fontSize: 12, color: Colors.white60),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
