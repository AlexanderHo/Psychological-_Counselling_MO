import 'package:flutter/material.dart';

import '../../model/news_model.dart';
import '../../reponsitory/news_.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class DailyPage extends StatelessWidget {
  List<HoroscopeFilter> _list1 = [
    HoroscopeFilter(name: 'Aries', status: false),
    HoroscopeFilter(name: 'Taurus', status: false),
    HoroscopeFilter(name: 'Germini', status: false),
    HoroscopeFilter(name: 'Cancer', status: false),
    HoroscopeFilter(name: 'Leo', status: false),
    HoroscopeFilter(name: 'Virgo', status: false),
    HoroscopeFilter(name: 'Libra', status: false),
    HoroscopeFilter(name: 'Scorpio', status: false),
    HoroscopeFilter(name: 'Sagittarius', status: false),
    HoroscopeFilter(name: 'Capricorn', status: false),
    HoroscopeFilter(name: 'Aquarius', status: false),
    HoroscopeFilter(name: 'Pisces', status: false),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        constraints:
            BoxConstraints(minHeight: size.height, minWidth: size.width),
        padding: EdgeInsets.fromLTRB(size.width * 0.03, size.height * 0.02,
            size.width * 0.03, size.height * 0.03),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background/background1.png'),
          fit: BoxFit.fill,
        )),
        child: Column(
          children: <Widget>[
            SafeArea(
                child: Row(
              children: <Widget>[
                Text(
                  'Tin tức',
                  style: TextStyle(
                    color: Color.fromRGBO(232, 212, 249, 0.8),
                    fontSize: size.height * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(154, 117, 240, 0.8),
                  radius: size.height * 0.025,
                  child: Icon(
                    Icons.search,
                    color: Color.fromRGBO(232, 212, 249, 0.8),
                    size: size.height * 0.04,
                  ),
                )
              ],
            )),
            SizedBox(
              height: size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Color.fromRGBO(43, 37, 60, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    title: Center(
                      child: Text(
                        'Chọn cung hoàng đạo',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    content: Container(
                      height: size.height * 0.3,
                      width: size.width * 0.8,
                      child: Column(
                        children: <Widget>[
                          HoroscopeBar(
                              s1: _list1[0], s2: _list1[1], s3: _list1[2]),
                          SizedBox(height: size.height * 0.01),
                          HoroscopeBar(
                              s1: _list1[3], s2: _list1[4], s3: _list1[5]),
                          SizedBox(height: size.height * 0.01),
                          HoroscopeBar(
                              s1: _list1[6], s2: _list1[7], s3: _list1[8]),
                          SizedBox(height: size.height * 0.01),
                          HoroscopeBar(
                              s1: _list1[9], s2: _list1[10], s3: _list1[11]),
                        ],
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.05,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                                // border: Border.all(color: Colors.white70),
                                ),
                            child: TextButton(
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Container(
                            height: size.height * 0.05,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                                // border: Border.all(color: Colors.white70),
                                ),
                            child: TextButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(0.20),
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(53, 25, 58, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.document_scanner,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      'Chọn danh mục',
                      style: TextStyle(
                        fontSize: size.height * 0.04,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            // FutureBuilder<List<NewsModel>>(
            //   future: fetchNewsData(http.Client()),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Center(
            //         child: Text('Something went wrong!!'),
            //       );
            //     } else if (snapshot.hasData) {
            //       return NewsList(newsModels: snapshot.data!);
            //     } else {
            //       return Container(
            //           height: size.height,
            //           child: Center(
            //             child: CircularProgressIndicator(),
            //           ));
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class HoroscopeFilter {
  String name;
  bool status;

  HoroscopeFilter({required this.name, required this.status});
}

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.newsModels}) : super(key: key);

  final List<NewsModel> newsModels;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: newsModels.length,
      itemBuilder: (BuildContext context, int index) {
        return NewPost(item: newsModels[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class HoroscopeBar extends StatefulWidget {
  HoroscopeFilter s1, s2, s3;
  HoroscopeBar({required this.s1, required this.s2, required this.s3});

  @override
  State<HoroscopeBar> createState() => _HoroscopeBarState();
}

class _HoroscopeBarState extends State<HoroscopeBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                widget.s1.status = !widget.s1.status;
              });
            },
            child: Text(
              widget.s1.name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
                backgroundColor: widget.s1.status
                    ? MaterialStateProperty.all(Color.fromRGBO(116, 55, 245, 1))
                    : MaterialStateProperty.all(Color.fromRGBO(41, 43, 61, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white70),
                )))),
        SizedBox(width: size.width * 0.02),
        ElevatedButton(
            onPressed: () {
              setState(() {
                widget.s2.status = !widget.s2.status;
              });
            },
            child: Text(
              widget.s2.name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
                backgroundColor: widget.s2.status
                    ? MaterialStateProperty.all(Color.fromRGBO(116, 55, 245, 1))
                    : MaterialStateProperty.all(Color.fromRGBO(41, 43, 61, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white70),
                )))),
        SizedBox(width: size.width * 0.02),
        ElevatedButton(
            onPressed: () {
              setState(() {
                widget.s3.status = !widget.s3.status;
              });
            },
            child: Text(
              widget.s3.name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
                backgroundColor: widget.s3.status
                    ? MaterialStateProperty.all(Color.fromRGBO(116, 55, 245, 1))
                    : MaterialStateProperty.all(Color.fromRGBO(41, 43, 61, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white70),
                )))),
      ],
    );
  }
}

class MyNewsDetail extends StatelessWidget {
  NewsModel item;
  MyNewsDetail({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String formatDate =
        DateFormat.yMMMd().format(DateTime.parse(item.createDay));
    return Scaffold(
      backgroundColor: Color.fromRGBO(109, 112, 122, 1),
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
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
      ),
      body: Container(
        // height: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.30,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(item.urlBanner),
                      fit: BoxFit.fitWidth)),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  // width: double.minPositive,
                  // height: size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Color.fromRGBO(27, 18, 53, 1)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          item.contentNews,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                      ),
                      Container(
                        child: ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromRGBO(116, 55, 245, 1)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color:
                                              Color.fromRGBO(116, 55, 245, 1)),
                                    )))),
                            ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  formatDate,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromRGBO(85, 81, 154, 1)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color:
                                              Color.fromRGBO(85, 81, 154, 1)),
                                    )))),
                          ],
                        ),
                      ),
                      Container(
                        child: Html(
                          data: item.description,
                          style: {
                            "strong": Style(
                              color: Colors.white,
                              fontSize: FontSize.larger,
                            ),
                            "p": Style(
                              color: Colors.white70,
                              fontSize: FontSize.large,
                            ),
                            "h1": Style(
                              color: Colors.white70,
                              fontSize: FontSize.larger,
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewPost extends StatelessWidget {
  NewsModel item;
  NewPost({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String formatDate =
        DateFormat.yMMMd().format(DateTime.parse(item.createDay));
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyNewsDetail(
                    item: item,
                  )),
        );
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              height: size.height * 0.2,
              width: size.width * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(item.urlBanner),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Container(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        item.title,
                        maxLines: 3,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              item.title,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(116, 55, 245, 1)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(116, 55, 245, 1)),
                                )))),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              formatDate,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(85, 81, 154, 1)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(85, 81, 154, 1)),
                                )))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
