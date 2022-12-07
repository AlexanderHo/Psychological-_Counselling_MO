import 'package:astrology/model/user.dart';
import 'package:astrology/reponsitory/Consultant_.dart';
import 'package:astrology/reponsitory/auth_repo.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/reponsitory/news_.dart';
import 'package:astrology/resourse/Astrologer/Astrologer.dart';
import 'package:astrology/resourse/Astrologer/AstrologerDetail.dart';
import 'package:astrology/resourse/Booking/booking.dart';
import 'package:astrology/resourse/Daily/DaiLyHocroscoe.dart';
import 'package:astrology/resourse/House/House.dart';
import 'package:astrology/resourse/NatalChart/NatalChart.dart';
import 'package:astrology/resourse/Planet/Planet.dart';
import 'package:astrology/resourse/Search/Search.dart';
import 'package:astrology/resourse/Zodiac/zodiaclist.dart';
import 'package:flutter/material.dart';
import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/Components/bottom_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/Consultant_model.dart';
import '../../model/news_model.dart';
import '../Call/call.dart';
import '../Daily/NewDetail.dart';
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
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Thông báo"),
              content: const Text('Bạn có muốn thoát???'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    AuthRepo().logout();
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Có'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Không'),
                )
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: TopBar.getAppBarHome(size, context),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          // padding: EdgeInsets.all(value),
          child: Container(
            color: Color(0xff17384e),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                //================================================================================
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 40, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bảng tin",
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 210,
                      width: 400,
                      child: FutureBuilder<List<NewsModel>>(
                          future: fetchNewsData(http.Client()),
                          builder: ((context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Something went wrong!!'),
                              );
                            } else if (snapshot.hasData) {
                              return NewList(newsModels: snapshot.data!);
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
                //=========================================================================================================NEAR SPA
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Chuyên gia giỏi",
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
                                  return AstrologerPage();
                                },
                              ));
                            },
                            child: Text(
                              "                            xem thêm",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DailyHocroscopePage()),
                        );
                      },
                      child: Container(
                        height: size.height * 0.4,
                        padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color.fromRGBO(80, 27, 101, 1),
                          image: DecorationImage(
                            image: AssetImage('assets/home/daily.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Lá số hằng ngày',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            'bạn có thể tìm hiểu tất tần tật về \nlá số của bạn',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                      backgroundColor: Colors.white,
                                      radius: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ZodiacListPage()),
                        );
                      },
                      child: Container(
                        height: size.height * 0.4,
                        padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color.fromRGBO(80, 27, 101, 1),
                          image: DecorationImage(
                            image: AssetImage('assets/home/zodiac.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Cung hoàng đạo',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            'bạn có thể tìm hiểu tất tần tật về \n12 cung hoàng đạo',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                      backgroundColor: Colors.white,
                                      radius: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NatalCharPage()),
                        );
                      },
                      child: Container(
                        height: size.height * 0.4,
                        padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color.fromRGBO(35, 66, 112, 1),
                          image: DecorationImage(
                            image: AssetImage('assets/home/natal-chart.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bản đồ sao',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            'bạn muốn hiểu rõ về con người \ncủa bạn? bạn đã đến đúng nơi rồi đó',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                      backgroundColor: Colors.white,
                                      radius: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlanetPage()),
                        );
                      },
                      child: Container(
                        height: size.height * 0.4,
                        padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color.fromRGBO(80, 27, 101, 1),
                          image: DecorationImage(
                            image: AssetImage('assets/home/planet.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hành Tinh',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            'bạn có thể tìm hiểu tất tần tật về \nhành tinh của bạn',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                      backgroundColor: Colors.white,
                                      radius: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HousePage()),
                        );
                      },
                      child: Container(
                        height: size.height * 0.4,
                        padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color.fromRGBO(35, 66, 112, 1),
                          image: DecorationImage(
                            image: AssetImage('assets/home/house.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nhà',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            'bạn có thể tìm hiểu về nhà trong thiên\nvăn học của bạn',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                      backgroundColor: Colors.white,
                                      radius: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xff031d2e),
          child: BottomBar(selected: "home"),
        ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AstroDetailPage(consulId: consulModels[index].id)),
                );
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
    int exp = item.experience ?? 0;
    double? rating = item.rating ?? 0.0;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 192,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white60),
          borderRadius: BorderRadius.circular(12.0),
          color: Color(0xff031d2e),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: size.height * 0.1,
                  width: size.width * 0.35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(item.imageUrl!),
                      )),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                item.fullName!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                ),
              ),
              Text(
                'Kinh nghiệm : Cấp độ ' + exp.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      itemSize: 25,
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                      ignoreGestures: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewList extends StatelessWidget {
  const NewList({Key? key, required this.newsModels}) : super(key: key);
  final List<NewsModel> newsModels;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NewdetailPage(id: newsModels[index].id)),
                );
              },
              child: NewsItem(
                item: newsModels[index],
              ));
        });
  }
}

class NewsItem extends StatelessWidget {
  NewsModel item;
  NewsItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        width: 300,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(12.0),
          color: Color(0xff031d2e),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: size.height * 0.15,
                  width: size.width * 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                          image: NetworkImage(item.urlBanner),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                ),
              ),
              // Text(
              //   'Kinh nghiệm :' + item.experience.toString() + ' năm',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.black54,
              //     fontWeight: FontWeight.w400,
              //     fontSize: 15.0,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
