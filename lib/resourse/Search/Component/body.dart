import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  String searchKey = "";

  Body({required this.searchKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [],
      ),
    );
  }
}
