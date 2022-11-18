import 'package:astrology/model/user.dart';
import 'package:astrology/reponsitory/Consultant_.dart';
import 'package:astrology/reponsitory/auth_repo.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/Booking/booking.dart';
import 'package:astrology/resourse/Search/Search.dart';
import 'package:flutter/material.dart';
import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/Components/bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/Consultant_model.dart';
import '../Call/call.dart';
import '../Daily/daily.dart';
import '../Live/live.dart';
import '../Matching/matching.dart';
import '../Planet/planet_detail.dart';
import '../Zodiac/zodiac.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UserModel> currentUser;
  @override
  void initState() {
    CurrentUser.init();
    super.initState();
    currentUser = AuthRepo().getCurrentUser();
    CurrentUser.saveCurrentUser(currentUser);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHome(size, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        // padding: EdgeInsets.all(value),
        child: Container(
          constraints:
              BoxConstraints(minHeight: size.height, minWidth: size.width),
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/background/anh-sao-bang.jpg'),
            fit: BoxFit.fitHeight,
          )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DailyPage();
                        },
                      ));
                    },
                    icon: Image.asset(
                      "assets/icon/daily-icon.png",
                      color: Colors.amber,
                    ),
                    iconSize: size.width * 0.2,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ZodiacPage();
                        },
                      ));
                    },
                    icon: Image.asset("assets/icon/zodiac_icon.png"),
                    iconSize: size.width * 0.25,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return MatchingPage();
                        },
                      ));
                    },
                    icon: Image.asset(
                      "assets/icon/match-icon.jpg",
                      color: Colors.amber,
                    ),
                    iconSize: size.width * 0.2,
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.push(context, MaterialPageRoute(
                  //       builder: (context) {
                  //         return ShopPage();
                  //       },
                  //     ));
                  //   },
                  //   icon: Image.asset("assets/icon/shop.jpg"),
                  //   iconSize: size.width * 0.2,
                  // )
                ],
              ),
              //=======================================================

              SizedBox(
                height: 20,
              ),
              //=========================================================================================================NEAR SPA
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Hot Astrologer",
                          style: TextStyle(
                              color: Colors.purple[100],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CallScreen();
                              },
                            ));
                          },
                          child: Text(
                            "                            See more",
                            style: TextStyle(
                                color: Colors.red[200],
                                fontSize: 17,
                                fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 210,
                    width: 400,
                    child: FutureBuilder<List<ConsultantModel>>(
                        future: fetchGeneralConsultantData(http.Client()),
                        builder: ((context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Something went wrong!!'),
                            );
                          } else if (snapshot.hasData) {
                            return ConsulList(consulModels: snapshot.data!);
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //================================================================
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Live",
                          style: TextStyle(
                              color: Colors.purple[100],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CallScreen();
                              },
                            ));
                          },
                          child: Text(
                            "                            See more",
                            style: TextStyle(
                                color: Colors.red[200],
                                fontSize: 18,
                                fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 210,
                  //   width: 400,
                  //   child: FutureBuilder<List<ConsultantModel>>(
                  //       future: fetchGeneralConsultantData(http.Client()),
                  //       builder: ((context, snapshot) {
                  //         if (snapshot.hasError) {
                  //           return Center(
                  //             child: Text('Something went wrong!!'),
                  //           );
                  //         } else if (snapshot.hasData) {
                  //           return ConsulList(consulModels: snapshot.data!);
                  //         } else {
                  //           return Center(
                  //             child: CircularProgressIndicator(),
                  //           );
                  //         }
                  //       })),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple.shade400,
        child: BottomBar(selected: "home"),
      ),
    );
  }
}

class ConsulList extends StatelessWidget {
  const ConsulList({Key? key, required this.consulModels}) : super(key: key);
  final List<ConsultantModel> consulModels;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: consulModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => PlanetdetailPage(
                //             id: planetModels[index].id,
                //           )),
                // );
              },
              child: ConsulItem(
                item: consulModels[index],
              ));
        });
  }
}

class ConsulItem extends StatelessWidget {
  ConsultantModel item;
  ConsulItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Container(
        width: 130,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.blueGrey[200],
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size.height * 0.1,
                width: size.width * 0.35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(item.imageUrl!),
                )),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                item.fullName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                ),
              ),
              Text(
                'Kinh nghiệm :' + item.experience.toString() + ' năm',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
