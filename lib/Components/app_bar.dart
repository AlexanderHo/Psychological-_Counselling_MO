import 'dart:ui';
import 'package:astrology/resourse/Wallet/wallet.dart';
import 'package:astrology/resourse/profile/add&editProfile/profile_detail.dart';

import 'package:flutter/material.dart';
import 'package:astrology/resourse/Login&register/login.dart';
import 'package:astrology/resourse/profile/account.dart';
import '../model/user.dart';
import '../resourse/notifi/notification.dart';

class TopBar {
  static AppBar getAppBarHome(Size size, BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff031d2e),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: size.width * 0.6,
              child: Text(
                "Psychological Counseling",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return AccountPage();
                    },
                  ));
                },
                icon: Image.asset(
                  "assets/icon/profile.png",
                  color: Color(0xFFff7010),
                  width: size.width * 0.08,
                ),
                iconSize: size.width * 0.07),
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(
            //         builder: (context) {
            //           return WalletPage();
            //         },
            //       ));
            //     },
            //     icon: Image.asset(
            //       "assets/icon/wallet-icon.png",
            //       color: Colors.purple,
            //       width: size.width * 0.06,
            //     ),
            //     iconSize: size.width * 0.05),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return notificationPage();
                  },
                ));
              },
              icon: Icon(
                Icons.notifications_active_outlined,
                color: Color(0xFFff7010),
                size: size.width * 0.08,
              ),
              iconSize: size.width * 0.07,
            )
          ],
        ));
  }

  static AppBar getAppBarHasBackIcon(
      Size size, BuildContext context, String title, Function() func) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Stack(alignment: Alignment.centerLeft, children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red[400],
                      fontSize: 20),
                ),
              )
            ],
          ),
        ),
        IconButton(
            onPressed: func,
            icon: Image.asset(
              "assets/icon/back.png",
              width: size.width * 0.07,
            )),
      ]),
      backgroundColor: Colors.white,
    );
  }
}
