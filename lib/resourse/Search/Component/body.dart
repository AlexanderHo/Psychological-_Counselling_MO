import 'package:astrology/model/Consultant_model.dart';
import 'package:astrology/model/ConsutantSpec_model.dart';
import 'package:astrology/reponsitory/Consultant_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Astrologer/AstrologerDetail.dart';

class Body extends StatelessWidget {
  String searchKey;

  Body({required this.searchKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 598,
              width: 500,
              child: FutureBuilder<List<ConsultantSpecModel>>(
                future: fetchGeneralConsultantBySpecial(searchKey),
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
    );
  }
}

class ConsulList extends StatelessWidget {
  const ConsulList({Key? key, required this.consulModels}) : super(key: key);
  final List<ConsultantSpecModel> consulModels;
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
                              consulId: consulModels[index].consultantId,
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
  ConsultantSpecModel item;
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
                      item.name!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(179, 25, 25, 25),
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'Kinh nghiệm : Cấp' + experience.toString(),
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
