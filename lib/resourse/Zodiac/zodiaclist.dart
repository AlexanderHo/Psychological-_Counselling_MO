import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/zodiac_model.dart';
import 'package:astrology/reponsitory/zodiac_.dart';
import 'package:astrology/resourse/Zodiac/zodiac_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/planet_model.dart';
import '../../reponsitory/planet_.dart';
import 'package:astrology/resourse/Planet/planet_detail.dart';

class ZodiacListPage extends StatefulWidget {
  @override
  State<ZodiacListPage> createState() => _ZodiacListPageState();
}

class _ZodiacListPageState extends State<ZodiacListPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHasBackIcon(size, context, 'Cung hoàng đạo', () {
        Navigator.pop(context);
      }),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background/background1.png'),
          fit: BoxFit.fill,
        )),
        child: FutureBuilder<List<ZodiacModel>>(
          future: fetchGeneralZodiacData(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong!!'),
              );
            } else if (snapshot.hasData) {
              return ZodiacList(ZodiacModels: snapshot.data!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class ZodiacList extends StatelessWidget {
  const ZodiacList({Key? key, required this.ZodiacModels}) : super(key: key);

  final List<ZodiacModel> ZodiacModels;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // mainAxisSpacing:10.0,
          // crossAxisSpacing:5.0,
          childAspectRatio: 0.9,
        ),
        itemCount: ZodiacModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ZodiacdetailPage(
                            id: ZodiacModels[index].id,
                          )),
                );
              },
              child: ZodiacItem(
                item: ZodiacModels[index],
              ));
        });
  }
}

class ZodiacItem extends StatelessWidget {
  ZodiacModel item;
  ZodiacItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: size.height * 0.15,
            width: size.width * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(item.imageUrl),
            )),
          ),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
