import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:astrology/resourse/Login&register/login.dart';

class TopBar {
  static AppBar getAppBarHome(Size size, BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: size.width * 0.6,
              child: Text(
                "Zodiac",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ));
                },
                icon: Image.asset(
                  "assets/icon/wallet-icon.png",
                  color: Colors.yellow,
                  width: size.width * 0.07,
                ),
                iconSize: size.width * 0.08),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ));
                },
                icon: Image.asset(
                  "assets/icon/account-icon.png",
                  color: Colors.yellow,
                  width: size.width * 0.07,
                ),
                iconSize: size.width * 0.08),
          ],
        ));
  }
}
