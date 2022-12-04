import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/reponsitory/ForgetPass.dart';
import 'package:astrology/resourse/Wallet/Momo.dart';
import 'package:astrology/resourse/Wallet/banking.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double paddingIcon = size.height * 0.009;
    double marginBetween = size.height * 0.017;
    return Scaffold(
        appBar: TopBar.getAppBarHasBackIcon(size, context, 'Quên mật khẩu', () {
          Navigator.pop(context);
        }),
        body: SafeArea(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //Icon
                      Container(
                        height: size.height * 0.09,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.black54),
                          color: const Color.fromRGBO(250, 250, 250, 0.1),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(paddingIcon),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                                  child: const Icon(
                                    Icons.account_box_outlined,
                                    size: 40,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                            //Column
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: amountController,
                                        validator: ((value) {
                                          if (value!.isEmpty) {
                                            return 'Vui lòng nhập tên đăng nhập';
                                          }
                                          return null;
                                        }),
                                        // maxLength: 4,
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 21.5),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Tên Đăng nhập',
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        textInputAction: TextInputAction.done,
                                        // autofillHints: [
                                        //   AutofillHints.creditCardNumber
                                        // ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //icon
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: const Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
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
                            if (_formKey.currentState!.validate()) {
                              ForgetPass(amountController.text);
                            }
                          },
                          child: Text(
                            'Lấy Mã',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
