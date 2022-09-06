import 'package:astrology/resourse/Live/live.dart';
import 'package:flutter/material.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/Schedule/schedule.dart';
import 'package:astrology/resourse/Call/call.dart';
import 'package:astrology/resourse/Chat/chat.dart';
import 'package:astrology/resourse/Shop/shop.dart';

class BottomBar extends StatelessWidget {
  String selected = "";
  Color colorSelected = Colors.white;
  Color colorNormal = Color.fromRGBO(87, 79, 79, 1);
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
                    color: Colors.white,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(fontSize: 12, color: Colors.white),
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
                    color: Colors.black45,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
            ),
          //=============================================================CALL
          if (selected == "Call")
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CallPage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/call_icon.png",
                    color: Colors.white,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Call",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              ),
            )
          else
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SchedulePage(finished: true);
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/call_icon.png",
                    color: Colors.black45,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Call",
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
            ),
          //=============================================================ZODIAC
          if (selected == "Zodiac")
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CallPage();
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/zodiac_icon.jpg",
                    color: Colors.white,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Zodiac",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              ),
            )
          else
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SchedulePage(finished: true);
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/zodiac_icon.jpg",
                    color: Colors.black45,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Zodiac",
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
            ),
          //=============================================================LIVE
          if (selected == "Live")
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
                    "assets/icon/live.png",
                    color: Colors.white,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Live",
                    style: TextStyle(fontSize: 12, color: Colors.white),
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
                    color: Colors.black45,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Live",
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
            ),
          //=============================================================SCHEDULE
          if (selected == "schedule")
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
                    "assets/icon/appointment.png",
                    color: Colors.white,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Schedule",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              ),
            )
          else
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SchedulePage(finished: true);
                  },
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/appointment.png",
                    color: Colors.black45,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Schedule",
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
