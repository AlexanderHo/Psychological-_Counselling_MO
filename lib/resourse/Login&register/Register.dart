import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:astrology/resourse/icon.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:astrology/resourse/Login&register/login.dart';
import 'package:flutter/material.dart';

import '../../model/province.dart';
import '../../model/user.dart';
import '../../reponsitory/auth_repo.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isHidePassword = true;
  Icon passwordIcon = const Icon(Icons.visibility);
  bool isHideConfirm = true;
  Icon confirmIcon = const Icon(Icons.visibility);
  DateTime? birthDate;
  DateFormat formatDate = DateFormat('yyyy-MM-dd');
  TimeOfDay? timeOfDay;
  String? selectedProvince;
  double? latitude;
  double? longitude;

  final fromKey = GlobalKey<FormState>();
  UserModel? user;

  // final auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final confirmController = TextEditingController();
  final nameController = TextEditingController();
  final genderController = GroupButtonController(selectedIndex: 0);
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double paddingIcon = size.height * 0.009;
    double marginBetween = size.height * 0.017;
    final applicationBloc = Provider.of<AuthRepo>(context);
    applicationBloc.getAllProvince();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background/phongnen.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.06),
                  child: const Text(
                    'Đăng Ký',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //name
                      Container(
                          height: size.height * 0.065,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.white70),
                            color: const Color.fromRGBO(250, 250, 250, 0.1),
                          ),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              //Icon
                              Container(
                                padding: EdgeInsets.all(paddingIcon),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: const Color.fromRGBO(0, 0, 0, 0.3),
                                    child: const Icon(
                                      MyFlutterApp.name,
                                      size: 40,
                                      color: Colors.white,
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
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.002),
                                        height: size.height * 0.019,
                                        child: const Text(
                                          'Họ và Tên',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.white38,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          child: SizedBox(
                                        height: size.height * 0.026,
                                        child: TextField(
                                          controller: nameController,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Nhập tên',
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          textInputAction: TextInputAction.done,
                                          autofillHints: [AutofillHints.name],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              //icon
                              Container(
                                padding: EdgeInsets.all(paddingIcon),
                                child: const Icon(
                                  MyFlutterApp.edit_2,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                      //gioi tinh
                      Container(
                          margin: EdgeInsets.only(top: marginBetween),
                          child: GroupButton(
                            controller: genderController,
                            isRadio: true,
                            buttons: const ["Nam", "Nữ"],
                            onSelected: (int index, bool isSelected) {},
                            selectedButton: 0,
                            selectedTextStyle: const TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white38,
                              fontSize: 14.0,
                            ),
                            selectedBorderColor:
                                const Color.fromRGBO(255, 74, 183, 1),
                            unselectedBorderColor: Colors.white70,
                            selectedColor:
                                const Color.fromRGBO(255, 74, 183, 1),
                            unselectedColor:
                                const Color.fromRGBO(250, 250, 250, 0.1),
                            unselectedTextStyle: const TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white38,
                              fontSize: 14.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                            buttonHeight: size.height * 0.065,
                            buttonWidth: size.width * 0.42,
                          )),
                      //mail
                      Container(
                          margin: EdgeInsets.only(top: marginBetween),
                          height: size.height * 0.065,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.white70),
                            color: const Color.fromRGBO(250, 250, 250, 0.1),
                          ),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              //Icon
                              Container(
                                padding: EdgeInsets.all(paddingIcon),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Container(
                                      color: const Color.fromRGBO(0, 0, 0, 0.3),
                                      child: const Icon(
                                        Icons.mail,
                                        size: 20,
                                        color: Colors.white,
                                      ),
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
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.002),
                                        height: size.height * 0.018,
                                        child: const Text(
                                          'Email',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.white38,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          child: SizedBox(
                                        height: size.height * 0.026,
                                        child: TextField(
                                          controller: emailController,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Thêm địa chỉ email',
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          autofillHints: const [
                                            AutofillHints.email
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              //icon
                              Container(
                                padding: EdgeInsets.all(paddingIcon),
                                child: const Icon(
                                  MyFlutterApp.edit_2,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                      //mobile
                      Container(
                          margin: EdgeInsets.only(top: marginBetween),
                          height: size.height * 0.065,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.white70),
                            color: const Color.fromRGBO(250, 250, 250, 0.1),
                          ),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              //Icon
                              Container(
                                padding: EdgeInsets.all(paddingIcon),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: const Color.fromRGBO(0, 0, 0, 0.3),
                                    child: const Icon(
                                      MyFlutterApp.phone,
                                      size: 40,
                                      color: Colors.white,
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
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.002),
                                        height: size.height * 0.018,
                                        child: const Text(
                                          'Mobile',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.white38,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          child: SizedBox(
                                        height: size.height * 0.026,
                                        child: const TextField(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Thêm số điện thoại',
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          keyboardType: TextInputType.phone,
                                          autofillHints: [
                                            AutofillHints.telephoneNumber
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              //icon
                              Container(
                                padding: EdgeInsets.all(paddingIcon),
                                child: const Icon(
                                  MyFlutterApp.edit_2,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                      //Ngày sinh
                      InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: marginBetween),
                            height: size.height * 0.065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(color: Colors.white70),
                              color: const Color.fromRGBO(250, 250, 250, 0.1),
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                //Icon
                                Container(
                                  padding: EdgeInsets.all(paddingIcon),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color: const Color.fromRGBO(0, 0, 0, 0.3),
                                      child: const Icon(
                                        MyFlutterApp.brithday,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                //Column
                                Expanded(
                                  child: Container(
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          child: Container(
                                            child: const Text(
                                              'Ngày sinh',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.white38,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                          top: 1,
                                          left: 0,
                                        ),
                                        Positioned(
                                          child: Container(
                                              child: SizedBox(
                                            child: Text(
                                              birthDate == null
                                                  ? 'Thêm ngày sinh'
                                                  : formatDate
                                                      .format(birthDate!),
                                              style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          )),
                                          bottom: 1,
                                          left: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //icon
                                Container(
                                  padding: EdgeInsets.all(paddingIcon),
                                  child: const Icon(
                                    MyFlutterApp.edit_2,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime(2222))
                              .then((value) {
                            setState(() {
                              birthDate = value;
                              print(birthDate);
                            });
                          });
                        },
                      ),
                      //Giờ sinh
                      InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: marginBetween),
                            height: size.height * 0.065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(color: Colors.white70),
                              color: const Color.fromRGBO(250, 250, 250, 0.1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                //Icon
                                Container(
                                  padding: EdgeInsets.all(paddingIcon),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color: const Color.fromRGBO(0, 0, 0, 0.3),
                                      child: const Icon(
                                        MyFlutterApp.brithtime,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                //Column
                                Expanded(
                                  child: Container(
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          child: Container(
                                              child: SizedBox(
                                            child: Text(
                                              timeOfDay == null
                                                  ? 'Thêm giờ sinh'
                                                  : '${timeOfDay!.hour.toString().padLeft(2, '0')}:${timeOfDay!.minute.toString().padLeft(2, '0')}',
                                              style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          )),
                                          bottom: 1,
                                          left: 0,
                                          top: 24,
                                        ),
                                        Positioned(
                                          child: Container(
                                            child: const Text(
                                              'Giờ sinh',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.white38,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                          top: 1,
                                          left: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //icon
                                Container(
                                  padding: EdgeInsets.all(paddingIcon),
                                  child: const Icon(
                                    MyFlutterApp.edit_2,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(
                                      hour: DateTime.now().hour,
                                      minute: DateTime.now().minute))
                              .then((value) {
                            setState(() {
                              timeOfDay = value;
                            });
                          });
                        },
                      ),
                      //Nơi sinh
                      Container(
                          margin: EdgeInsets.only(top: marginBetween),
                          height: size.height * 0.065,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.white70),
                            color: const Color.fromRGBO(250, 250, 250, 0.1),
                          ),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              //Icon
                              Container(
                                padding: EdgeInsets.all(paddingIcon),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: const Color.fromRGBO(0, 0, 0, 0.3),
                                    child: const Icon(
                                      MyFlutterApp.brithday,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              //Column
                              Expanded(
                                child: Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        width: size.width * 0.85,
                                        bottom: 0,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                              isExpanded: true,
                                              hint: Text(
                                                selectedProvince == null
                                                    ? 'Thêm thành Phố'
                                                    : selectedProvince
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              items: applicationBloc.provinces!
                                                  .map<
                                                      DropdownMenuItem<
                                                          Province>>((a) {
                                                return DropdownMenuItem(
                                                  child: Text(
                                                    a.name,
                                                  ),
                                                  value: a,
                                                );
                                              }).toList(),
                                              icon: Icon(
                                                MyFlutterApp.chevron_down,
                                                color: Colors.white,
                                              ),
                                              onChanged: (Province? value) {
                                                setState(() {
                                                  selectedProvince =
                                                      value!.name;
                                                });
                                              }),
                                        ),
                                        left: 0,
                                        top: 24,
                                      ),
                                      Positioned(
                                        child: Container(
                                          child: Text(
                                            'Nơi sinh',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.white38,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        top: 1,
                                        left: 0,
                                      ),
                                      // TextField(
                                      //   style: TextStyle(
                                      //       color: Colors.white, fontSize: 20),
                                      //   decoration: InputDecoration(
                                      //     border: InputBorder.none,
                                      //     hintText: 'Thêm thành Phố',
                                      //     hintStyle: TextStyle(
                                      //         color: Colors.white,
                                      //         fontSize: 20),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              // icon
                              // Container(
                              //   padding: EdgeInsets.all(paddingIcon),
                              //   child: Icon(
                              //     MyFlutterApp.chevron_down,
                              //     size: 16,
                              //     color: Colors.white,
                              //   ),
                              // ),
                            ],
                          )),
                      // king độ vĩ độ
                      InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: marginBetween),
                            height: (latitude == null && longitude == null)
                                ? size.height * 0.065
                                : size.height * 0.065 * 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(color: Colors.white70),
                              color: Color.fromRGBO(250, 250, 250, 0.1),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //Icon
                                Container(
                                  padding: EdgeInsets.all(paddingIcon),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color: Color.fromRGBO(0, 0, 0, 0.3),
                                      child: Icon(
                                        MyFlutterApp.place,
                                        size: 40,
                                        color: Colors.white,
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
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.002),
                                          height: size.height * 0.018,
                                          child: Text(
                                            'Kinh / Vĩ độ',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.white38,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        (longitude == null && latitude == null)
                                            ? Container(
                                                child: SizedBox(
                                                child: const Text(
                                                  "Chọn địa chỉ",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                // TextField(
                                                //   style: TextStyle(color: Colors.white, fontSize: 20),
                                                //   decoration: InputDecoration(
                                                //     border: InputBorder.none,
                                                //     hintText: 'Chọn địa chỉ',
                                                //     hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                                                //   ),
                                                // ),
                                              ))
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Text(
                                                    'Kinh độ',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.white38,
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    longitude.toString(),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Vĩ độ',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.white38,
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    latitude.toString(),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                //icon
                                Container(
                                  padding: EdgeInsets.only(
                                      top: size.height * 0.02,
                                      right: paddingIcon),
                                  child: Icon(
                                    MyFlutterApp.gps,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context)=> const MapScreen())
                          // );
                          applicationBloc.setCurrentLocation();
                          setState(() {
                            longitude =
                                applicationBloc.currentLocation!.longitude;
                            latitude =
                                applicationBloc.currentLocation!.latitude;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.026),
                  child: Text(
                    'Mật khẩu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 25.0,
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            obscureText: isHideConfirm,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Xác nhận mật Khẩu',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(250, 250, 250, 0.1),
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
                // button dk
                Container(
                  margin:
                      EdgeInsets.only(top: size.height * 0.026, bottom: 10.0),
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
                        // Profile profile = Profile(
                        //     id: 0,
                        //     name: nameController.text,
                        // birthDate: formatDate.format(birthDate!) +
                        //     'T' +
                        //     '${timeOfDay!.hour.toString().padLeft(2, '0')}:${timeOfDay!.minute.toString().padLeft(2, '0')}',
                        //     birthPlace: selectedProvince.toString(),
                        //     profilePhoto: "",
                        //     longitude: longitude!,
                        //     latitude: latitude!,
                        //     userId: 0,
                        //     gender: genderController.selectedIndex == 0
                        //         ? true
                        //         : false);
                        // applicationBloc.signUp(emailController.text,
                        //     passWordController.text, profile);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      } else {
                        passWordController.clear();
                        confirmController.clear();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text('Mật khẩu không khớp. thử lại'),
                              );
                            });
                      }
                    },
                    child: Text(
                      'Đăng Ký',
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
          ),
        ),
      ),
    );
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
