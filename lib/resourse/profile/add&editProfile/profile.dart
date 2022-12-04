import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/user.dart';
import 'package:astrology/reponsitory/user_.dart';
import 'package:astrology/resourse/profile/add&editProfile/add_profile.dart';
import 'package:astrology/resourse/profile/add&editProfile/profile_detail.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Color(0xff17384e),
        constraints:
            BoxConstraints(minHeight: size.height, minWidth: size.width),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Thông tin khác',
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
                        // SizedBox(width: size.width * 0.04),
                        // GestureDetector(
                        //     onTap: () {
                        //       // final provider = Provider.of<GoogleSignInProvider>(
                        //       //     context,
                        //       //     listen: false);
                        //       // provider.logout();
                        //       AuthRepo().logout();
                        //     },
                        //     child: CircleAvatar(
                        //       child: Icon(Icons.logout),
                        //       backgroundColor: Colors.blue,
                        //       radius: 15,
                        //     )),
                      ],
                    ),
                  ),
                ),
              ),
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
