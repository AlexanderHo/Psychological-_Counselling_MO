import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';

import '../model/user.dart';

class CurrentUser {
  static SharedPreferences? _prefs;

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future<void> saveCurrentUser(Future<UserModel> user) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    UserModel userTemp = await user;
    print("load ở đây");
    await _prefs.setInt('id', userTemp.id);
    print(_prefs.getInt('id'));

    // await _prefs.setInt('id', userTemp.profileList[0].id);
    await _prefs.setString('address', userTemp.address);
    await _prefs.setString('fullname', userTemp.name);
    print("xuong fulname");
    print(_prefs.setString('fullname', userTemp.name));
    await _prefs.setString('email', userTemp.email);
    // await _prefs.setString('phoneNumber', userTemp.phone);
    await _prefs.setString('imageUrl', userTemp.imageUrl);
    await _prefs.setString('birthchart', userTemp.birthchart);
    print(_prefs.setString('birthchart', userTemp.birthchart));
    await _prefs.setString('gender', userTemp.gender);
    String date = DateFormat.yMd().format(DateTime.parse(userTemp.dob));
    // String time = DateFormat.Hm()
    //     .format(DateTime.parse(userTemp.profileList[0].birthDate));
    await _prefs.setInt('zodiacId', userTemp.zodiacId);
    await _prefs.setString('dob', date);
    // await _prefs.setString('time', time);
    await _prefs.setString('longitude', userTemp.longitude);
    await _prefs.setString('latitude', userTemp.latitude);
  }

  static Future<void> updateCurrentUser(String name, String date, String place,
      String gender, String image, String longitude, String latitude) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('fullname', name);
    print("chay update");
    print(_prefs.getInt('id'));
    await _prefs.setString('dob', date);
    await _prefs.setString('address', place);
    await _prefs.setString('longitude', longitude);
    await _prefs.setString('latitude', latitude);
    await _prefs.setString('gender', gender);
    await _prefs.setString('imageUrl', image);
  }

  static int? getUserId() {
    return _prefs?.getInt('id');
  }

  // static int? getId() {
  //   return _prefs.getInt('id');
  // }

  static String? getPlace() {
    return _prefs?.getString('address');
  }

  static String? getDate() {
    return _prefs?.getString('dob');
  }

  static String? getEmail() {
    return _prefs?.getString('email');
  }

  static double? getLongitude() {
    return _prefs?.getDouble('longitude');
  }

  static double? getLatitude() {
    return _prefs?.getDouble('latitude');
  }

  static String? getCurrentUserName() {
    return _prefs?.getString('fullname');
  }

  static String? getGender() {
    return _prefs?.getString('gender');
  }

  static String? getAvatarLink() {
    return _prefs?.getString('imageUrl');
  }

  static String? getChart() {
    return _prefs?.getString('birthchart');
  }

  static int? getZodiacId() {
    return _prefs?.getInt('zodiacId');
  }

  static String? getlink() {
    return _prefs?.getString('urlImage');
  }
}
