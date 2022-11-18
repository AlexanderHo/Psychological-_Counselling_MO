import 'package:astrology/model/planet_model.dart';
import 'package:astrology/model/zodiac_model.dart';
import 'package:astrology/reponsitory/planet_.dart';
import 'package:astrology/reponsitory/zodiac_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class ZodiacdetailPage extends StatefulWidget {
  int id;
  ZodiacdetailPage({required this.id});

  @override
  State<ZodiacdetailPage> createState() => _ZodiacdetailPageState();
}

class _ZodiacdetailPageState extends State<ZodiacdetailPage> {
  late Future<ZodiacModel> planet;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planet = fetchZodiacDetailData(widget.id);
  }

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
            size: 15.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, size.height * 0.1, 15.0, 20.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background/background1.png'),
                  fit: BoxFit.fill)),
          child: FutureBuilder<ZodiacModel>(
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
              color: Colors.black,
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
