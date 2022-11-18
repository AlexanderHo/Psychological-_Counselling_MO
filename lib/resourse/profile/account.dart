import 'package:astrology/reponsitory/auth_repo.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/Wallet/wallet.dart';
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
        constraints:
            BoxConstraints(minHeight: size.height, minWidth: size.width),
        padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background/background1.png'),
          fit: BoxFit.fill,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      'Hồ sơ',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProfilePage()));
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        radius: 15.0,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    SizedBox(width: size.width * 0.04),
                    GestureDetector(
                        onTap: () {
                          // final provider = Provider.of<GoogleSignInProvider>(
                          //     context,
                          //     listen: false);
                          // provider.logout();
                          AuthRepo().logout();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.logout),
                          backgroundColor: Colors.blue,
                          radius: 15,
                        )),
                  ],
                ),
              ),
            ),

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
                            width: size.width * 0.35,
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
                                  'Chỉnh sửa hồ sơ',
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
                      'Lịch sử thanh toán',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                      size: 15.0,
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(0.0, 2.0, 0, 1.0),
              child: Text(
                'Hồ sơ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),

            // ListView.separated(
            //   shrinkWrap: true,
            // padding: const EdgeInsets.all(8),
            // itemCount: widget.profileList.length,
            // itemBuilder: (BuildContext context, int index) {
            // if(index != 0){
            //   return Follower(imageLink: widget.profileList[index].profilePhoto, name:widget.profileList[index].name,item:widget.profileList[index],);
            // }else{
            //   return SizedBox();
            // }
            // },
            // separatorBuilder: (BuildContext context, int index) => const Divider(),
            // ),

            FutureBuilder<List<Profile>>(
              future: fetchListProfile(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Chưa có hồ sơ',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 25.0,
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return ProfileList(profileList: snapshot.data!);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileList extends StatelessWidget {
  const ProfileList({Key? key, required this.profileList}) : super(key: key);

  final List<Profile> profileList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // padding: const EdgeInsets.all(8),
        itemCount: profileList.length,
        itemBuilder: (BuildContext context, int index) {
          // if (index != 0) {
          //   return Follower(
          //     item: profileList[index],
          //     name: profileList[index].name,
          //     // imageLink: profileList[index].,
          //   );
          // } else {
          //   return SizedBox();
          // }
          return Follower(
            item: profileList[index],
            name: profileList[index].name,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox());
  }
}

class Follower extends StatelessWidget {
  // String imageLink;
  String name;
  Profile item;

  Follower({required this.name, required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileDetailPage(item: item)),
        );
      },
      child: Container(
        height: size.height * 0.1,
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 233, 235),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: <Widget>[
            // CircleAvatar(
            //   backgroundImage: NetworkImage(imageLink),
            //   radius: 20.0,
            // ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              name,
              style: TextStyle(
                color: Color.fromARGB(255, 86, 32, 77),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              height: size.height * 0.05,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 74, 183, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
