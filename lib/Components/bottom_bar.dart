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

// class BottomBar extends StatefulWidget {
//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> {
//   late PageController _pageController;

//   int _selectedIndex = 0;

//   late Future<UserModel> currentUser;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     _pageController.animateToPage(index,
//         duration: Duration(milliseconds: 500), curve: Curves.easeIn);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(
//       initialPage: _selectedIndex,
//     );
//     currentUser = GoogleSignInProvider().getCurrentUser();
//     CurrentUser.saveCurrentUser(currentUser);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<UserModel>(
//         future: currentUser,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Something went wrong!!'),
//             );
//           } else if (snapshot.hasData) {
//             return PageView(
//               controller: _pageController,
//               onPageChanged: (newPage) {
//                 setState(() {
//                   _selectedIndex = newPage;
//                 });
//               },
//               children: [
//                 // HomePage(),
//                 HomeScreen(),
//                 CallPage(),
//                 ShopPage(),
//                 LivePage(),
//                 SchedulePage(finished: true),
//               ],
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 1000.0,
//         backgroundColor: Color.fromRGBO(154, 117, 240, 0.8),
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Color.fromRGBO(255, 46, 171, 1.0),
//         unselectedItemColor: Colors.white,
//         showUnselectedLabels: true,
//         items: [
//           BottomNavigationBarItem(
//             icon: ImageIcon(AssetImage('assets/icon/home.png')),
//             label: 'Home',
//             backgroundColor: Color.fromRGBO(154, 117, 240, 0.8),
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(AssetImage('assets/icon/call_icon.png')),
//             label: 'Call',
//             backgroundColor: Color.fromRGBO(154, 117, 240, 0.8),
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(AssetImage('assets/icon/shop.jpg')),
//             label: 'Shop',
//             backgroundColor: Color.fromRGBO(154, 117, 240, 0.8),
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(AssetImage('assets/icon/live.png')),
//             label: 'Live',
//             backgroundColor: Color.fromRGBO(154, 117, 240, 0.8),
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(AssetImage('assets/icon/appointment.png')),
//             label: 'Lịch',
//             backgroundColor: Color.fromRGBO(154, 117, 240, 0.8),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
          //=============================================================APPOINTMENT
          if (selected == "Call")
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
                    return SurveyTypePage();
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
          //=============================================================SEARCH
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
                    color: Colors.white,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Consultant",
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
                    color: Colors.black45,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Consultant",
                    style: TextStyle(fontSize: 12, color: Colors.black45),
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
                  ),
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
                    color: Colors.black45,
                    width: size.width * 0.09,
                  ),
                  Text(
                    "Schedule",
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
