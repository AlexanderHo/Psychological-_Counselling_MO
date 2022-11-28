import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/reponsitory/Consultant_.dart';
import 'package:astrology/resourse/Astrologer/AstrologerDetail.dart';
import 'package:astrology/resourse/SlotBooking/Slot_Booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import '../../Components/bottom_bar.dart';
import '../../model/Consultant_model.dart';
import '../Search/Search.dart';

class AstrologerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHome(size, context),
      body: Container(
        constraints:
            BoxConstraints(minHeight: size.height, minWidth: size.width),
        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background/anh-sao-bang.jpg'),
          fit: BoxFit.fitHeight,
        )),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                  left: size.height * 0.005, right: size.height * 0.005),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            height: size.height * 0.05,
                            width: size.width * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.purple.shade100,
                                border: Border.all(
                                    color: Color.fromARGB(179, 33, 32, 32))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return SearchScreen(
                                              searchKey: "Bạn bè");
                                        },
                                      ));
                                    },
                                    icon: Image.asset("assets/icon/love.png"),
                                    iconSize: size.width * 0.02,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  'Bạn bè',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            height: size.height * 0.05,
                            width: size.width * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.purple.shade100,
                                border: Border.all(
                                    color: Color.fromARGB(179, 33, 32, 32))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return SearchScreen(
                                              searchKey: "Sự nghiệp");
                                        },
                                      ));
                                    },
                                    icon: Image.asset("assets/icon/job.png"),
                                    iconSize: size.width * 0.02,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  'Sự nghiệp',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            height: size.height * 0.05,
                            width: size.width * 0.265,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.purple.shade100,
                                border: Border.all(
                                    color: Color.fromARGB(179, 33, 32, 32))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return SearchScreen(
                                              searchKey: "Gia Đình");
                                        },
                                      ));
                                    },
                                    icon: Image.asset(
                                      "assets/icon/mariage.png",
                                    ),
                                    iconSize: size.width * 0.02,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  'Gia Đình',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            height: size.height * 0.05,
                            width: size.width * 0.26,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.purple.shade100,
                                border: Border.all(
                                    color: Color.fromARGB(179, 33, 32, 32))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return SearchScreen(
                                              searchKey: "#Health");
                                        },
                                      ));
                                    },
                                    icon: Image.asset("assets/icon/health.png"),
                                    iconSize: size.width * 0.02,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  'Sức khỏe',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            height: size.height * 0.05,
                            width: size.width * 0.275,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.purple.shade100,
                                border: Border.all(
                                    color: Color.fromARGB(179, 33, 32, 32))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return SearchScreen(
                                              searchKey: "Chuyên môn khác");
                                        },
                                      ));
                                    },
                                    icon: Image.asset(
                                        "assets/icon/education.png"),
                                    iconSize: size.width * 0.02,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  'Chuyên môn khác',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ))
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 598,
                width: 500,
                child: FutureBuilder<List<ConsultantModel>>(
                  future: fetchGeneralConsultantData(http.Client()),
                  builder: (context, snapshot) {
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff031d2e),
        child: BottomBar(selected: "Consultant"),
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
        scrollDirection: Axis.vertical,
        itemCount: consulModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AstroDetailPage(
                              consulId: consulModels[index].id,
                            )));
                // MaterialPageRoute(
                //   builder: (context) =>
                //       SlotBookingPage(consultantId: consulModels[index].id),
                // ));
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
    double? rating = item.rating ?? 0.0;
    int? experience = item.experience ?? 0;

    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.blueGrey[200],
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size.height * 0.15,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl!),
                    )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.fullName!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(179, 25, 25, 25),
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'Kinh nghiệm : Cấp ' + experience.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(179, 23, 23, 23),
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'Địa chỉ : ' + item.address! ?? '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(179, 23, 23, 23),
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
