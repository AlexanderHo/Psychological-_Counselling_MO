import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/reponsitory/add_profile.dart';
import 'package:flutter/material.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final _formKey = GlobalKey<FormState>();
  final oldPassController = TextEditingController();
  bool isHidePassword = true;
  Icon passwordIcon = const Icon(Icons.visibility);
  bool isHideConfirm = true;
  Icon confirmIcon = const Icon(Icons.visibility);
  final passWordController = TextEditingController();
  final confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double paddingIcon = size.height * 0.009;
    double marginBetween = size.height * 0.017;
    return Scaffold(
        appBar: TopBar.getAppBarHasBackIcon(size, context, 'Đổi mật khẩu', () {
          Navigator.pop(context);
        }),
        body: SafeArea(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  color: Color(0xff17384e),
                  height: 700,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                  height: size.height * 0.065,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white70,
                                  ),
                                  child: SizedBox(
                                    height: size.height * 0.026,
                                    child: TextField(
                                      controller: oldPassController,
                                      style: const TextStyle(
                                          color: Colors.black54, fontSize: 20),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'mật khẩu cũ',
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      autofillHints: const [
                                        AutofillHints.email
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),

                      //
                      Container(
                        padding: EdgeInsets.only(top: size.height * 0.026),
                        child: Text(
                          'Mật khẩu mới',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: size.height * 0.017),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //Mật k hẩu
                              Container(
                                margin: EdgeInsets.only(top: marginBetween),
                                padding: EdgeInsets.only(
                                    left: size.width * 0.05,
                                    right: size.width * 0.05),
                                // height: size.height*0.054,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(color: Colors.white70),
                                  color: Color.fromRGBO(250, 250, 250, 0.1),
                                ),
                                child: TextField(
                                  controller: passWordController,
                                  obscureText: isHidePassword,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Mật Khẩu',
                                    hintStyle: TextStyle(
                                      color: Color.fromRGBO(250, 250, 250, 0.1),
                                      fontSize: 20,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: viewPassword,
                                      child: passwordIcon,
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: marginBetween),
                                padding: EdgeInsets.only(
                                    left: size.width * 0.05,
                                    right: size.width * 0.05),
                                // height: size.height*0.054,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(color: Colors.white70),
                                  color: Color.fromRGBO(250, 250, 250, 0.1),
                                ),
                                child: TextField(
                                  controller: confirmController,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  obscureText: isHideConfirm,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Xác nhận mật Khẩu',
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromRGBO(250, 250, 250, 0.1),
                                        fontSize: 20),
                                    suffixIcon: InkWell(
                                      onTap: viewConfirm,
                                      child: confirmIcon,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.height * 0.026, bottom: 10.0),
                        height: size.height * 0.08,
                        width: size.width * 1,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(116, 55, 245, 1),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.white70)),
                        child: OutlinedButton(
                          onPressed: () {
                            if (passWordController.text
                                    .compareTo(confirmController.text) ==
                                0) {
                              changePass(oldPassController.text,
                                  passWordController.text);
                            } else {
                              passWordController.clear();
                              confirmController.clear();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content:
                                          Text('Mật khẩu không khớp. thử lại'),
                                    );
                                  });
                            }
                          },
                          child: Text(
                            'Đổi mật khẩu',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))));
  }

  void viewPassword() {
    setState(() {
      isHidePassword = !isHidePassword;
      if (isHidePassword)
        passwordIcon = Icon(Icons.visibility);
      else
        passwordIcon = Icon(Icons.visibility_off);
    });
  }

  void viewConfirm() {
    setState(() {
      isHideConfirm = !isHideConfirm;
      if (isHideConfirm)
        confirmIcon = Icon(Icons.visibility);
      else
        confirmIcon = Icon(Icons.visibility_off);
    });
  }
}
