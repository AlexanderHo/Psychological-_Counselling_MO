import 'dart:developer';

import 'package:astrology/model/province.dart';
import 'package:astrology/reponsitory/auth_repo.dart';
import 'package:astrology/resourse/profile/account.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../../reponsitory/add_profile.dart';
import '../../../reponsitory/current_user_shared_preferences.dart';
import '../../Home/home.dart';
import '../../icon.dart';

class AddProfilePage extends StatefulWidget {
  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  String _imageUrl = '';

  TimeOfDay? timeOfDay;
  DateTime? birthDate;
  DateFormat formatDate = DateFormat('yyyy-MM-dd');
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? selectedValue;

  int userId = CurrentUser.getUserId() ?? 0;

  final List<AccountInformation> _list = [
    AccountInformation(
        icon: Icons.person, title: 'Họ và tên', content: 'Điền họ và tên'),
    AccountInformation(
        icon: Icons.cake, title: 'Ngày sinh', content: 'Điền ngày sinh'),
    AccountInformation(
        icon: Icons.place, title: 'Nơi sinh', content: 'Điền nơi sinh'),
    // AccountInformation(
    //     icon: Icons.circle, title: 'Vĩ Độ', content: 'Điền vĩ độ'),
    // AccountInformation(
    //     icon: Icons.radar, title: 'Kinh Độ', content: 'Điền kinh độ'),
  ];

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    // String res = await uploadImage(image.path);
    // setState(() {
    //   _imageUrl = res;
    // });
    // log('image URL :'+imageUrl);
  }

  final _nameController = TextEditingController();
  String _name = '';
  final _dateController = TextEditingController();
  String _date = '';

  final _genderController = TextEditingController();
  String _gender = '';
  // final _latitudeController = TextEditingController();
  double? latitude;
  // final _longitudeController = TextEditingController();
  double? longitude;
  String? selectedProvince;
  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   // _dateController.dispose();
  //   _placeController.dispose();
  //   // _latitudeController.dispose();
  //   // _longitudeController.dispose();
  //   super.dispose();
  // }

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
          'Thêm hồ sơ',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15.0, 5.0, 15.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Color.fromRGBO(0, 117, 255, 1),
                          )))),
              onPressed: () async {
                _name = _nameController.text;
                // _date = _dateController.text;
                _date = formatDate.format(birthDate!) +
                    'T' +
                    '${timeOfDay!.hour.toString().padLeft(2, '0')}:${timeOfDay!.minute.toString().padLeft(2, '0')}';
                final query = selectedProvince.toString() + ", Vietnam";
                var add = await Geocoder.local.findAddressesFromQuery(query);
                var second = add.first;
                print("${second.featureName} : ${second.coordinates}");
                setState(() {
                  longitude = second.coordinates.longitude;
                  latitude = second.coordinates.latitude;
                });
                addProfile(_name, _date, selectedProvince.toString(), latitude!,
                    longitude!, _gender, userId);

                // MaterialPageRoute(
                //   builder:
                //       (context) => /*NatalChartProfilePage(item: widget.item,)*/
                //           HomeScreen(),
                // );

                // Navigator.pop(context);
              },
              child: Text(
                'Thêm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, 10, 15.0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Center(
              //   child: Container(
              //     height: size.height * 0.16,
              //     width: size.width * 0.3,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(15.0),
              //       image: DecorationImage(
              //         image: NetworkImage(_imageUrl),
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //     child: Stack(
              //       children: [
              //         Positioned(
              //           bottom: 0,
              //           right: 0,
              //           child: GestureDetector(
              //             onTap: () {
              //               pickImage();
              //               // uploadImage(path);
              //             },
              //             child: CircleAvatar(
              //               backgroundColor: Colors.white,
              //               child: Icon(
              //                 Icons.camera_alt,
              //                 color: Colors.black,
              //               ),
              //               radius: 15.0,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: size.height * 0.03,
              ),
              /* Name TextField*/
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
                              Icons.person,
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
                                  'Ho và Tên',
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
                                    hintText: 'Điền vào tên',
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
                hint: const Text(
                  'Giới tính',
                  style: TextStyle(fontSize: 14, color: Colors.white),
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
                    return 'Làm ơn chọn giới tính.';
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
              const SizedBox(height: 30),

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
                                Icons.cake,
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
                                          : formatDate.format(birthDate!),
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
              SizedBox(
                height: size.height * 0.01,
              ),
              /*Place TextField*/
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
                              Icons.location_city,
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
                      // icon
                      Container(
                        padding: EdgeInsets.all(paddingIcon),
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: size.height * 0.01,
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

class CustomDropdownButton2 extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset? offset;

  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        //To avoid long text overflowing.
        isExpanded: true,
        hint: Container(
          alignment: hintAlignment,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
        value: value,
        items: dropdownItems
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Container(
                    alignment: valueAlignment,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ))
            .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
        iconSize: iconSize ?? 12,
        iconEnabledColor: iconEnabledColor,
        iconDisabledColor: iconDisabledColor,
        buttonHeight: buttonHeight ?? 40,
        buttonWidth: buttonWidth ?? 140,
        buttonPadding:
            buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: buttonDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black45,
              ),
            ),
        buttonElevation: buttonElevation,
        itemHeight: itemHeight ?? 40,
        itemPadding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
        dropdownMaxHeight: dropdownHeight ?? 200,
        dropdownWidth: dropdownWidth ?? 140,
        dropdownPadding: dropdownPadding,
        dropdownDecoration: dropdownDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
        dropdownElevation: dropdownElevation ?? 8,
        scrollbarRadius: scrollbarRadius ?? const Radius.circular(40),
        scrollbarThickness: scrollbarThickness,
        scrollbarAlwaysShow: scrollbarAlwaysShow,
        //Null or Offset(0, 0) will open just under the button. You can edit as you want.
        offset: offset,
        dropdownOverButton: false, //Default is false to show menu below button
      ),
    );
  }
}
