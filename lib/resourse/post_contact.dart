import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Hello Consultant",
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}
