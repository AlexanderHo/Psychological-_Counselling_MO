import 'package:astrology/blocs/auth_bloc.dart';
import 'package:astrology/blocs/auth_events.dart';
import 'package:astrology/blocs/auth_state.dart';
import 'package:astrology/reponsitory/auth_repo.dart';
import 'package:astrology/reponsitory/user_.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/Login&register/Register.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../model/user.dart';
import '../../reponsitory/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  late AuthBloc authBloc;
  late Future<UserModel> currentUser;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);

    FirebaseMessaging.instance
        .getToken()
        .then((value) => AuthRepo().setTokenDevice(value!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final msg = BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoginErrorState) {
          return Text(state.message);
        } else if (state is LoginLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );

    final username = TextField(
      controller: userName,
      // keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Color(0xFFF2F3F5),
        hintStyle: TextStyle(
          color: Color(0xFF666666),
        ),
        hintText: 'userName',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
    final pass = TextField(
      controller: password,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        filled: true,
        fillColor: Color(0xFFF2F3F5),
        hintStyle: TextStyle(
          color: Color(0xFF666666),
        ),
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
    final loginBotton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: OutlinedButton(
        onPressed: () {
          authBloc.add(LoginBottonPressed(
              userName: userName.text, password: password.text));
        },
        child: Text(
          'Đăng nhập',
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.blue,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is CustomerLoginSuccessState) {
            Navigator.pushNamed(context, '/customer');
          } else if (state is ConsultantLoginSuccessState) {
            Navigator.pushNamed(context, '/consultant');
          }
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(size.height * 0.1),
            color: Color.fromARGB(255, 235, 224, 252),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: size.height * 0.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background/zodiac1.png'),
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: size.height * 0.18,
                        child: Text(
                          'Đăng nhập',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                msg,
                SizedBox(height: 48.0),
                username,
                SizedBox(height: 20.0),
                pass,
                SizedBox(height: 24.0),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(),
                      Spacer(),
                      GestureDetector(
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                loginBotton,
                Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 30.0),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20.0,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
