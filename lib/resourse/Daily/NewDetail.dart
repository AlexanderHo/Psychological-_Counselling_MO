import 'package:astrology/model/planet_model.dart';
import 'package:astrology/reponsitory/news_.dart';
import 'package:astrology/reponsitory/planet_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../model/news_model.dart';

class NewdetailPage extends StatefulWidget {
  int id;
  NewdetailPage({required this.id});

  @override
  State<NewdetailPage> createState() => _NewdetailPageState();
}

class _NewdetailPageState extends State<NewdetailPage> {
  late Future<NewsModel> news;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    news = fetchNewDetailData(widget.id);
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
          child: FutureBuilder<NewsModel>(
            future: news,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('something went wrong!!',
                      style: TextStyle(color: Colors.black)),
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
  NewsModel item;
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
              image: NetworkImage(item.urlBanner),
              fit: BoxFit.fill,
            )),
          ),
          Text(
            item.createDay,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          // Text(
          //   item.title,
          //   style: TextStyle(
          //     fontSize: 15.0,
          //     color: Colors.white70,
          //     wordSpacing: 5.0,
          //   ),
          // ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            item.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            item.description,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Html(
            data: item.contentNews,
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
          // SizedBox(
          //   height: 15.0,
          // ),
          // Container(
          //   padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          //   child: Html(
          //     data: item.mainContent,
          //     style: {
          //       "strong": Style(
          //         color: Colors.white70,
          //         fontSize: FontSize.larger,
          //       ),
          //       "p": Style(
          //         color: Colors.white70,
          //         fontSize: FontSize.large,
          //       ),
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
