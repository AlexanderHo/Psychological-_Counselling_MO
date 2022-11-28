import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/resourse/Daily/DaiLyHocroscoe.dart';
import 'package:astrology/resourse/Daily/NewDetail.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/House/House.dart';
import 'package:astrology/resourse/NatalChart/NatalChart.dart';
import 'package:astrology/resourse/Planet/Planet.dart';
import 'package:astrology/resourse/Zodiac/zodiaclist.dart';
import 'package:astrology/resourse/profile/account.dart';
import 'package:flutter/material.dart';

class ZodiacPage extends StatefulWidget {
  const ZodiacPage({super.key});

  @override
  State<ZodiacPage> createState() => _ZodiacPageState();
}

class _ZodiacPageState extends State<ZodiacPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHasBackIcon(size, context, 'Zodiac', () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        primary: false,
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 20.0),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/background/background1.png'),
            fit: BoxFit.fill,
          )),
          child: Column(
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
                                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    MaterialPageRoute(builder: (context) => ZodiacListPage()),
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
                                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    MaterialPageRoute(builder: (context) => NatalCharPage()),
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
                        top: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        top: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      ),
    );
  }
}
