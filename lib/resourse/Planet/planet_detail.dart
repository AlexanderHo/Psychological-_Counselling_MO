import 'package:astrology/model/planet_model.dart';
import 'package:astrology/reponsitory/planet_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PlanetdetailPage extends StatefulWidget {
  int id;
  PlanetdetailPage({required this.id});

  @override
  State<PlanetdetailPage> createState() => _PlanetdetailPageState();
}

class _PlanetdetailPageState extends State<PlanetdetailPage> {
  late Future<PlanetModel> planet;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planet = fetchPlanetDetailData(widget.id);
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
          padding: EdgeInsets.fromLTRB(15.0, size.height * 0.1, 15.0, 0.0),
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('assets/background/background1.png'),
          //         fit: BoxFit.fill)),
          color: Color(0xff17384e),
          child: FutureBuilder<PlanetModel>(
            future: planet,
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
  PlanetModel item;
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
            'Sơ lược về ' + item.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Html(
            data: item.description,
            style: {
              "strong": Style(
                color: Colors.white,
                fontSize: FontSize.larger,
              ),
              "p": Style(
                color: Colors.white,
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
              data: item.mainContent,
              style: {
                "strong": Style(
                  color: Colors.white70,
                  fontSize: FontSize.larger,
                ),
                "p": Style(
                  color: Colors.white,
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
