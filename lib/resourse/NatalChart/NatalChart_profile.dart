import 'package:astrology/model/Deposit_model.dart';
import 'package:astrology/model/Match_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/reponsitory/deposit_.dart';
import 'package:astrology/reponsitory/user_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NatalChartProfilePage extends StatefulWidget {
  String name;
  int id;
  String chart;
  NatalChartProfilePage(
      {required this.name, required this.id, required this.chart});

  @override
  State<NatalChartProfilePage> createState() => _NatalChartProfilePageState();
}

class _NatalChartProfilePageState extends State<NatalChartProfilePage> {
  late Future<MatchModel> match;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    match = matching(widget.id);
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
                Text("Cung ho??ng ?????o c???a : " + widget.name,
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    )),
                // Container(
                //   height: size.height * 0.5,
                //   width: size.width * 0.855,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //     image: NetworkImage(widget.chart),
                //     fit: BoxFit.fill,
                //   )),
                // ),
                FutureBuilder<MatchModel>(
                  future: match,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('something went wrong!!',
                            style: TextStyle(color: Colors.white70)),
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
  MatchModel item;
  ShowDetail({required this.item});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Html(
            data: item.zodiacprofile,
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
          Text("Cung ho??ng ?????o c???a b???n ",
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              )),
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            child: Html(
              data: item.zodiaccustomer,
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
          Text(
            "????? ph?? h???p l?? : " + item.compatibility,
            style: TextStyle(
              color: Colors.amber[600],
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
