import 'package:astrology/model/province.dart';
import 'package:astrology/reponsitory/auth_repo.dart';
import 'package:astrology/reponsitory/update-Image_.dart';
import 'package:astrology/resourse/icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';

import '../../../reponsitory/add_profile.dart';
import '../../../reponsitory/current_user_shared_preferences.dart';

class EditAccountPage extends StatefulWidget {
  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  File? _imageFile;
  String? urlImage;
  DateTime? birthDate;
  DateFormat formatDate = DateFormat('yyyy-MM-dd');
  String _name = CurrentUser.getCurrentUserName() ?? '';

  String _date = CurrentUser.getDate() ?? '';

  String _place = CurrentUser.getPlace() ?? '';

  String? _imageLink = CurrentUser.getAvatarLink() ?? '';

  String _gender = CurrentUser.getGender() ?? '';

  int userId = CurrentUser.getUserId() ?? 0;
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? selectedValue;
  final List<AccountInformation> _list = [
    AccountInformation(
        icon: Icons.person, title: 'Họ và tên', content: 'Hieu Nguyen'),
    AccountInformation(
        icon: Icons.cake, title: 'Ngày sinh', content: '28-09-2000'),
    AccountInformation(
        icon: Icons.place, title: 'Nơi sinh', content: '12:52:52'),
  ];

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        loadImageCustomer(_imageFile!);
        _imageLink = CurrentUser.getAvatarLink() ?? '';
        Navigator.of(context).pop();
      });
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        loadImageCustomer(_imageFile!);
        _imageLink = CurrentUser.getlink();
        Navigator.of(context).pop();
      });
    }
  }

  final _nameController = TextEditingController();
  String name = '';
  final _dateController = TextEditingController();
  String date = '';
  final _placeController = TextEditingController();
  String place = '';
  double? latitude;
  double? longitude;
  String? selectedProvince;
  bool isLoadling = false;
  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _placeController.dispose();
    // _latitudeController.dispose();
    // _longitudeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    selectedProvince = _place;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double paddingIcon = size.height * 0.009;
    double marginBetween = size.height * 0.017;
    final applicationBloc = Provider.of<AuthRepo>(context);
    applicationBloc.getAllProvince();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(27, 18, 53, 1),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(27, 18, 53, 1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 15.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Chỉnh sửa hồ sơ',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.fromLTRB(0, 15.0, 5.0, 15.0),
        //     child: ElevatedButton(
        //       style: ButtonStyle(
        //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //               RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(10.0),
        //                   side: BorderSide(
        //                     color: Color.fromRGBO(0, 117, 255, 1),
        //                   )))),
        //       onPressed: () {
        //         name = _nameController.text;
        //         if (name.isEmpty) {
        //           setState(() {
        //             name = _name;
        //           });
        //         }
        //         date = _dateController.text;
        //         if (date.isEmpty) {
        //           setState(() {
        //             date = _date;
        //           });
        //         }
        //         place = _placeController.text;
        //         if (place.isEmpty) {
        //           setState(() {
        //             place = _place;
        //           });
        //         }
        //         // _date = formatDate.format(birthDate!);
        //         // latitude = double.parse(_latitudeController.text);
        //         // if(latitude == 0){
        //         //   setState(() {
        //         //     latitude = _latitude;
        //         //   });
        //         // }
        //         // longitude = double.parse(_longitudeController.text);
        //         // if(longitude == 0){
        //         //   setState(() {
        //         //     longitude=_longitude;
        //         //   });
        //         // // }
        //         updateProfile(userId, name, place, _gender, _imageLink!);
        //         // updateProfile(userId, name, place, _gender);

        //         CurrentUser.updateCurrentUser(
        //             name, date, place, _gender, _imageLink!);
        //         // AppRouter.push(HomeScreen());
        //       },
        //       child: Text(
        //         'Lưu',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, 10, 15.0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  height: size.height * 0.16,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: NetworkImage(_imageLink!),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Center(
                                          child:
                                              const Text("Chọn ảnh của bạn?")),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            TextButton.icon(
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.blueGrey[200],
                                              ),
                                              label: Center(
                                                  child: Text(
                                                'Chọn ảnh từ camera',
                                              )),
                                              onPressed: () {
                                                _getFromCamera();
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            TextButton.icon(
                                              icon: Icon(
                                                Icons.photo_album_outlined,
                                                color: Colors.blueGrey[200],
                                              ),
                                              label: Center(
                                                child: Text('Chọn ảnh có sẵn'),
                                              ),
                                              onPressed: () {
                                                _getFromGallery();
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    )).then((value) => exitCode);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                            radius: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              /*Name TextField*/
              Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70),
                    color: Color.fromRGBO(250, 250, 250, 0.1),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //Icon
                      Container(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            child: Icon(
                              _list[0].icon,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 2),
                                height: 17,
                                child: Text(
                                  _list[0].title,
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
                                height: 24,
                                child: TextField(
                                  controller: _nameController,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: _name,
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      //icon
                    ],
                  )),
              SizedBox(
                height: size.height * 0.01,
              ),
              DropdownButtonFormField2(
                decoration: InputDecoration(
                  //Add isDense true and zero Padding.
                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //Add more decoration as you want here
                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                ),
                isExpanded: true,
                hint: Text(
                  _gender,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.amber,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Giới tính';
                  }
                },
                onChanged: (value) {
                  //Do something when changing the item if you want.
                  setState(() {
                    selectedValue = value.toString();
                    _gender = selectedValue!;
                  });
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                  // _gender = selectedValue!;
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              /*Date*/
              /*Date TextField*/
              Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70),
                    color: Color.fromRGBO(250, 250, 250, 0.1),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //Icon
                      Container(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            child: Icon(
                              _list[1].icon,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 2),
                                height: 17,
                                child: Text(
                                  _list[1].title,
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
                                height: 24,
                                child: TextField(
                                  controller: _dateController,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: _date,
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      //icon
                    ],
                  )),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70),
                    color: Color.fromRGBO(250, 250, 250, 0.1),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //Icon
                      Container(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            child: Icon(
                              _list[2].icon,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      //Column
                      //
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
                                            : selectedProvince.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      items: applicationBloc.provinces!
                                          .map<DropdownMenuItem<Province>>((a) {
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
                                          selectedProvince = value!.name;
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
                            ],
                          ),
                        ),
                      ),
                      //icon
                    ],
                  )),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      color: Color.fromRGBO(0, 117, 255, 1),
                                    )))),
                    onPressed: () async {
                      setState(() {
                        isLoadling = true;
                      });

                      name = _nameController.text;
                      if (name.isEmpty) {
                        setState(() {
                          name = _name;
                        });
                      }
                      date = _dateController.text;
                      if (date.isEmpty) {
                        setState(() {
                          date = _date;
                        });
                      }
                      place = _placeController.text;
                      if (place.isEmpty) {
                        setState(() {
                          place = _place;
                        });
                      }
                      final query = selectedProvince.toString() + ", Vietnam";
                      var add =
                          await Geocoder.local.findAddressesFromQuery(query);
                      var second = add.first;
                      print("${second.featureName} : ${second.coordinates}");
                      setState(() {
                        longitude = second.coordinates.longitude;
                        latitude = second.coordinates.latitude;
                      });
                      // updateProfile(userId, name, selectedProvince.toString(),
                      //     _gender, _imageLink!);
                      updateProfile(userId, name, selectedProvince.toString(),
                          latitude!, longitude!, _gender, _imageLink!);
                      // updateProfile(userId, name, place, _gender);
                      CurrentUser.updateCurrentUser(
                          name,
                          date,
                          selectedProvince.toString(),
                          _gender,
                          _imageLink!,
                          longitude!.toString(),
                          latitude!.toString());

                      Future.delayed(
                        Duration(seconds: 10),
                        () {
                          setState(() {
                            isLoadling = false;
                          });
                        },
                      );
                    },
                    child: isLoadling
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Lưu',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountItem extends StatefulWidget {
  AccountInformation item;

  AccountItem({required this.item});

  @override
  State<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller =
        TextEditingController(text: widget.item.content);
    bool _isEnable = false;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
      child: Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.white),
        child: Material(
          color: Color.fromRGBO(27, 18, 53, 1),
          child: Container(
            height: size.height * 0.1,
            color: Color.fromRGBO(38, 30, 63, 1),
            child: TextField(
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.white,
              ),
              controller: _controller,
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white70,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white70,
                  ),
                ),
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Color.fromRGBO(27, 18, 53, 1),
                      child: Icon(
                        widget.item.icon,
                        color: Colors.white,
                      )),
                ),
                label: Text(
                  widget.item.title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AccountInformation {
  IconData icon;
  String title;
  String content;

  AccountInformation(
      {required this.icon, required this.title, required this.content});
}

class AccountItem1 extends StatefulWidget {
  AccountInformation item;

  AccountItem1({required this.item});

  @override
  State<AccountItem1> createState() => _AccountItem1State();
}

class _AccountItem1State extends State<AccountItem1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.white70),
          color: Color.fromRGBO(250, 250, 250, 0.1),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Icon
            Container(
              padding: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  child: Icon(
                    widget.item.icon,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      height: 17,
                      child: Text(
                        widget.item.title,
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
                      height: 24,
                      child: TextField(
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.item.content,
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            //icon
            Container(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.edit,
                size: 16,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }
}
