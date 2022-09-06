import 'package:flutter/material.dart';
import 'package:astrology/resourse/Wallet/wallet.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return WalletPage();
                    },
                  ));
                },
                icon: Image.asset("assets/icon/daily-icon.png"),
                iconSize: size.width * 0.2,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return WalletPage();
                    },
                  ));
                },
                icon: Image.asset("assets/icon/zodiac_icon.jpg"),
                iconSize: size.width * 0.2,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return WalletPage();
                    },
                  ));
                },
                icon: Image.asset("assets/icon/match-icon.jpg"),
                iconSize: size.width * 0.2,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return WalletPage();
                    },
                  ));
                },
                icon: Image.asset("assets/icon/shop.jpg"),
                iconSize: size.width * 0.2,
              )
            ],
          ),
          //=======================================================
          Padding(
              padding: EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Column(children: <Widget>[
                //============================================================HOT ASTROLOGER
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Live Astrologer",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return WalletPage();
                            },
                          ));
                        },
                        child: Text(
                          "See more",
                          style: TextStyle(
                              color: Colors.red[200],
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
