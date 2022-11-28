import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/resourse/Wallet/Momo.dart';
import 'package:astrology/resourse/Wallet/banking.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final methodController = GroupButtonController(selectedIndex: 0);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double paddingIcon = size.height * 0.009;
    double marginBetween = size.height * 0.017;
    return Scaffold(
        appBar: TopBar.getAppBarHasBackIcon(size, context, 'Nạp tiền', () {
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
                                    Icons.monetization_on_outlined,
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
                                            return 'Làm ơn nhập số tiền cần nạp';
                                          } else if (int.parse(value) < 20 ||
                                              int.parse(value) > 20000) {
                                            return 'Tiền nạp từ 20 đến 1000 cua';
                                          }
                                          return null;
                                        }),
                                        // maxLength: 4,
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 21.5),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Số Gem',
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
                      Text(
                          '*1 Gem = 1.000 VND.\n* Bạn có thể nạp từ 20 đến 20.000 Gem.',
                          style: TextStyle(color: Colors.red, fontSize: 12)),
                      Container(
                          margin: EdgeInsets.only(top: marginBetween),
                          child: GroupButton(
                            controller: methodController,
                            isRadio: true,
                            buttons: const ["Momo", "Banking"],
                            onSelected: (int index, bool isSelected) {},
                            selectedButton: 0,
                            selectedTextStyle: const TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black54,
                              fontSize: 14.0,
                            ),
                            selectedBorderColor:
                                const Color.fromRGBO(255, 74, 183, 1),
                            unselectedBorderColor: Colors.black54,
                            selectedColor:
                                const Color.fromRGBO(255, 74, 183, 1),
                            unselectedColor:
                                const Color.fromRGBO(250, 250, 250, 0.1),
                            unselectedTextStyle: const TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black54,
                              fontSize: 14.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                            buttonHeight: size.height * 0.065,
                            buttonWidth: size.width * 0.42,
                          )),
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
                            if (methodController.selectedIndex == 0) {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MomoPage(amount: amountController)),
                                );
                              }
                            } else {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BakingPage(amount: amountController)),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Nạp',
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
