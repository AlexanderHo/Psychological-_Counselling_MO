import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/Consultant_model.dart';
import 'package:astrology/model/Feedback_model.dart';
import 'package:astrology/model/Specializations_model.dart';
import 'package:astrology/reponsitory/Consultant_.dart';
import 'package:astrology/reponsitory/FeedBack_.dart';
import 'package:astrology/reponsitory/Specia_.dart';
import 'package:astrology/resourse/Astrologer/Astrologer.dart';
import 'package:astrology/resourse/SlotBooking/Slot_Booking.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AstroDetailPage extends StatefulWidget {
  int consulId;
  AstroDetailPage({required this.consulId});

  @override
  State<AstroDetailPage> createState() => _AstroDetailPageState();
}

class _AstroDetailPageState extends State<AstroDetailPage> {
  late Future<ConsultantModel> consult;
  // late Future<List<SpeciaModel>> spec;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    consult = fetchConsultantDetailData(widget.consulId);
    // spec = fetchSpec(widget.consulId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: TopBar.getAppBarHasBackIcon(size, context, 'Chuyên gia', () {
          AppRouter.push(AstrologerPage());
        }),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            constraints:
                BoxConstraints(minHeight: size.height, minWidth: size.width),
            color: Color(0xff031d2e),
            // padding: EdgeInsets.fromLTRB(15.0, size.height * 0.1, 15.0, 0.0),
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('assets/background/background1.png'),
            //         fit: BoxFit.fill)),
            // mainAxisAlignment: MainAxisAlignment.start,
            // children: [
            child: Column(
              children: [
                Container(
                  // height: ,
                  // width: 420,
                  child: FutureBuilder<ConsultantModel>(
                    future: consult,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('something went wrong!!',
                              style: TextStyle(color: Colors.white)),
                        );
                      } else if (snapshot.hasData) {
                        return ShowDetail(item: snapshot.data!);
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
              ],
            ),
          ),
        ));
  }
}

class ShowDetail extends StatelessWidget {
  ConsultantModel item;
  ShowDetail({required this.item});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double? rating = item.rating ?? 0.0;
    int? experience = item.experience ?? 0;
    return Container(
      // width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              height: size.height * 0.25,
              width: size.width * 0.45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage(item.imageUrl!),
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () async {
                    final url = 'https://zalo.me/${item.phone}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  icon: Image.asset(
                    "assets/icon/zalo.png",
                    color: Color(0xFFff7010),
                    width: size.width * 0.08,
                  ),
                  iconSize: size.width * 0.09),
              IconButton(
                  onPressed: () async {
                    final url = 'sms:${item.phone}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  icon: Image.asset(
                    "assets/icon/sms.png",
                    color: Color(0xFFff7010),
                    width: size.width * 0.08,
                  ),
                  iconSize: size.width * 0.09),
            ],
          ),
          Text(
            'Chuyên gia:' + item.fullName!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Giới tính : ' + item.gender!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Địa chỉ : ' + item.address!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Email : ' + item.email,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Số điện thoại : ' + item.phone!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          // Container(
          //   height: 50,
          //   width: 420,
          //   child: FutureBuilder<List<SpeciaModel>>(
          //     future: fetchSpec(item.id),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         return Center(
          //           child: Text('something went wrong!!',
          //               style: TextStyle(color: Colors.black54)),
          //         );
          //       } else if (snapshot.hasData) {
          //         return SpecList(SpeciaModels: snapshot.data!);
          //       } else {
          //         return Container(
          //             height: size.height,
          //             child: Center(
          //               child: CircularProgressIndicator(),
          //             ));
          //       }
          //     },
          //   ),
          // ),
          Text(
            'Chuyên môn :' + item.specialization!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Kinh nhiệm: Cấp độ ' + experience.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  'Đánh giá :',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SlotBookingPage(consultantId: item.id),
                          ));
                    },
                    child: Text(
                      'Lịch làm việc',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 598,
              width: 500,
              child: FutureBuilder<List<FeedBackModel>>(
                future: fetchFeedBack(item.id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong!!'),
                    );
                  } else if (snapshot.hasData) {
                    return FeedbackList(feedBackModels: snapshot.data!);
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
    );
  }
}

class FeedbackList extends StatelessWidget {
  const FeedbackList({Key? key, required this.feedBackModels})
      : super(key: key);

  final List<FeedBackModel> feedBackModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: feedBackModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
              child: SpeciaItem(
                item: feedBackModels[index],
              ));
        });
  }
}

class SpeciaItem extends StatelessWidget {
  FeedBackModel item;
  SpeciaItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(15.0),
          color: Color(0xff17384e),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Text(
                item.customerName,
                style: TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                item.dateCreate,
                style: TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    RatingBar.builder(
                      itemSize: 20,
                      initialRating: item.rate.toDouble(),
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
              SizedBox(
                height: 5.0,
              ),
              Text(
                item.feedback,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
