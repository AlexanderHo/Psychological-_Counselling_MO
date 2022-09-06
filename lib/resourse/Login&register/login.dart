import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astrology/resourse/Login&register/Register.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:astrology/resourse/Home/home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(size.height * 0.05),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/phongnen.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size.height * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background/sun.jpg'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: size.height * 0.07,
                      child: Text(
                        'Đăng nhập',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70)),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                padding: EdgeInsets.only(left: 10.0),
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70)),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Mật khẩu',
                    hintStyle: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(),
                    Spacer(),
                    GestureDetector(
                      child: Text(
                        'Quên mật khẩu?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                height: size.height * 0.08,
                width: size.width * 1,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(227, 65, 201, 1),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70)),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 30.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  )),
              Container(
                  child: Row(children: <Widget>[
                Expanded(
                    child: Divider(
                  color: Colors.white,
                  endIndent: 10.0,
                )),
                Text(
                  "OR",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.white,
                  indent: 10.0,
                )),
              ])),
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                height: size.height * 0.08,
                width: size.width * 1,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(15, 81, 180, 1),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70)),
                child: OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.facebook_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Facebook',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                height: size.height * 0.08,
                width: size.width * 1,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 62, 62, 1),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70)),
                child: OutlinedButton(
                  onPressed: () {
                    // final provider = Provider.of<GoogleSignInProvider>(
                    //     context, listen: false);
                    // provider.googleLogin();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.google, color: Colors.white),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Google',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
