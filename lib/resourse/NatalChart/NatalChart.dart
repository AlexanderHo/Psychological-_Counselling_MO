import 'package:astrology/model/Deposit_model.dart';
import 'package:astrology/model/zodiac_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/reponsitory/deposit_.dart';
import 'package:astrology/reponsitory/zodiac_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class NatalCharPage extends StatefulWidget {
  // String chart;
  // NatalCharPage({required this.chart});

  @override
  State<NatalCharPage> createState() => _NatalCharPageState();
}

class _NatalCharPageState extends State<NatalCharPage> {
  late Future<ZodiacModel> planet;
  int? zodiacId = CurrentUser.getZodiacId() ?? 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planet = fetchZodiacDetailData(zodiacId!);
  }

  String? chart = CurrentUser.getChart() ?? '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Colors.white70,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          constraints:
              BoxConstraints(minHeight: size.height, minWidth: size.width),
          padding: EdgeInsets.fromLTRB(15.0, size.height * 0.1, 15.0, 0.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background/background1.png'),
                  fit: BoxFit.fill)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Bản đồ sao của bạn :",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                Container(
                  height: size.height * 0.5,
                  width: size.width * 0.855,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(chart!),
                    fit: BoxFit.fill,
                  )),
                ),
                FutureBuilder<ZodiacModel>(
                  future: planet,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('something went wrong!!',
                            style: TextStyle(color: Colors.white60)),
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
              ]),
        ),
      ),
    );
  }
}

class ShowDetail extends StatelessWidget {
  ZodiacModel item;
  ShowDetail({required this.item});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: size.height * 0.25,
            width: size.width * 0.45,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(item.imageUrl),
              fit: BoxFit.fill,
            )),
          ),
          Text(
            item.name,
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
            'Sơ lược về ' + item.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Từ ngày : ' +
                item.dayStart.toString() +
                "/" +
                item.monthStart.toString(),
            style: TextStyle(
              color: Colors.white60,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          Text(
            'Đến ngày : ' +
                item.dayEnd.toString() +
                "/" +
                item.monthEnd.toString(),
            style: TextStyle(
              color: Colors.white60,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Html(
            data: item.descriptionShort,
            style: {
              "strong": Style(
                color: Colors.white,
                fontSize: FontSize.larger,
              ),
              "p": Style(
                color: Colors.white70,
                fontSize: FontSize.large,
              ),
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            child: Html(
              data: item.descriptionDetail,
              style: {
                "strong": Style(
                  color: Colors.white70,
                  fontSize: FontSize.larger,
                ),
                "p": Style(
                  color: Colors.white70,
                  fontSize: FontSize.large,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
