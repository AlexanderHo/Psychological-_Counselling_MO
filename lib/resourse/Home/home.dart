import 'package:flutter/material.dart';
import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/Components/bottom_bar.dart';
import 'package:astrology/resourse/Home/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHome(size, context),
      body: Body(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.red,
        child: BottomBar(
          selected: "home",
        ),
      ),
    );
  }
}
