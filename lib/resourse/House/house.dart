import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/house_model.dart';
import 'package:astrology/reponsitory/house_.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'house_detail.dart';

class HousePage extends StatefulWidget {
  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  late Future<List<HouseModel>> houseList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    houseList = fetchGeneralHouseData(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TopBar.getAppBarHasBackIcon(size, context, 'Các nhà', () {
        Navigator.pop(context);
      }),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background/background1.png'),
          fit: BoxFit.fill,
        )),
        child: FutureBuilder<List<HouseModel>>(
          future: houseList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong!!'),
              );
            } else if (snapshot.hasData) {
              return HouseList(houseModels: snapshot.data!);
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

class HouseList extends StatelessWidget {
  const HouseList({Key? key, required this.houseModels}) : super(key: key);

  final List<HouseModel> houseModels;

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
        itemCount: houseModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HouseDetail(
                            id: houseModels[index].id,
                          )),
                );
              },
              child: HouseItem(
                item: houseModels[index],
              ));
        });
  }
}

class HouseItem extends StatelessWidget {
  HouseModel item;
  HouseItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2000),
                image: DecorationImage(
                  image: NetworkImage(item.imageUrl!),
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
