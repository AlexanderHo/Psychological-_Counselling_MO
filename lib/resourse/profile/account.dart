import 'package:astrology/model/wallet_model.dart';
import 'package:astrology/reponsitory/Wallet_.dart';
import 'package:astrology/reponsitory/auth_repo.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/Wallet/wallet.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:astrology/resourse/profile/add&editProfile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../model/user.dart';

// import '../../reponsitory/google_sign_in.dart';
import '../../reponsitory/user_.dart';
import 'add&editProfile/add_profile.dart';
import 'add&editProfile/edit_account.dart';
import 'add&editProfile/profile_detail.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _imageLink = CurrentUser.getAvatarLink() ?? '';
  String _name = CurrentUser.getCurrentUserName() ?? '';
  String gender = CurrentUser.getGender() ?? '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Color(0xff17384e),
        constraints:
            BoxConstraints(minHeight: size.height, minWidth: size.width),
        // padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage('assets/background/background1.png'),
        //   fit: BoxFit.fill,
        // )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SafeArea(
            //   child: Container(
            //     child: Row(
            //       children: <Widget>[
            //         Text(
            //           'Hồ sơ',
            //           style: TextStyle(
            //             fontSize: 20.0,
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         Spacer(),
            //         // GestureDetector(
            //         //   onTap: () {
            //         //     Navigator.push(
            //         //         context,
            //         //         MaterialPageRoute(
            //         //             builder: (context) => AddProfilePage()));
            //         //   },
            //         //   child: CircleAvatar(
            //         //     child: Icon(
            //         //       Icons.add,
            //         //       color: Colors.white,
            //         //     ),
            //         //     radius: 15.0,
            //         //     backgroundColor: Colors.blue,
            //         //   ),
            //         // ),
            //         SizedBox(width: size.width * 0.04),
            //         GestureDetector(
            //             onTap: () {
            //               // final provider = Provider.of<GoogleSignInProvider>(
            //               //     context,
            //               //     listen: false);
            //               // provider.logout();
            //               AuthRepo().logout();
            //             },
            //             child: CircleAvatar(
            //               child: Icon(Icons.logout),
            //               backgroundColor: Colors.blue,
            //               radius: 15,
            //             )),
            //       ],
            //     ),
            //   ),
            // ),

            Container(
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: size.height * 0.16,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: NetworkImage(_imageLink),
                        // image: NetworkImage(
                        //     'https://scontent.fsgn5-15.fna.fbcdn.net/v/t39.30808-6/306828431_463684089115167_4431332057427388959_n.jpg?stp=dst-jpg_s851x315&_nc_cat=1&ccb=1-7&_nc_sid=da31f3&_nc_ohc=2T7JscA9QIQAX9DCc0c&tn=_lI93l0CeEEGW7vN&_nc_ht=scontent.fsgn5-15.fna&oh=00_AT_3X_s_P62ilsmxjXBf6waUEw_lFvG1UFlagSONKVuEWA&oe=6325CE27'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            child: Icon(
                                gender == "Male" ? Icons.male : Icons.female),
                            backgroundColor: gender == "Male"
                                ? Color.fromRGBO(25, 88, 255, 0.8)
                                : Color.fromRGBO(255, 74, 183, 0.8),
                            radius: 15.0,
                            // child: Icon(Icons.male),
                            // radius: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          _name,
                          // 'Hồ Quốc Khải',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: FutureBuilder<WalletModel>(
                            future: fetchWallet(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('something went wrong!!',
                                      style: TextStyle(color: Colors.black54)),
                                );
                              } else if (snapshot.hasData) {
                                return wallet(item: snapshot.data!);
                              } else {
                                return Container(
                                    height: size.height,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ));
                              }
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAccountPage()),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(10.0),
                            height: size.height * 0.06,
                            width: size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.white70),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Chỉnh sửa thông tin',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletPage()),
                );
              },
              child: Container(
                height: size.height * 0.12,
                padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Color.fromRGBO(129, 102, 134, 1.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.1,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                        image: AssetImage('assets/icon/wallet-icon.png'),
                        fit: BoxFit.fill,
                      )),
                    ),
                    Text(
                      'Ví của bạn ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                      size: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Container(
                height: size.height * 0.12,
                padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Color.fromRGBO(129, 102, 134, 1.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.1,
                      decoration: BoxDecoration(
                          // color: Colors.black,
                          image: DecorationImage(
                        image: AssetImage('assets/icon/profile_con.png'),
                        fit: BoxFit.fill,
                      )),
                    ),
                    Text(
                      'Hồ sơ phụ  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                      size: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                AuthRepo().logout();
              },
              child: Container(
                height: size.height * 0.12,
                padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Color.fromRGBO(129, 102, 134, 1.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.1,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                        image: AssetImage('assets/icon/logout.png'),
                        fit: BoxFit.fill,
                      )),
                    ),
                    Text(
                      'Đăng xuất ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                      size: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class wallet extends StatelessWidget {
  WalletModel item;
  wallet({required this.item});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Số Gem : ' + item.crab.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'roboto'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
