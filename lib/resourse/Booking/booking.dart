import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/reponsitory/booking_.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  // const BookingPage({super.key});
  int slotId;
  String? timeStart;
  String? timeEnd;
  int? price;
  String? dateSlot;
  String? consultantName;
  String? imageUrl;
  int consultantId;
  int customerId;
  BookingPage({
    required this.slotId,
    required this.timeStart,
    required this.timeEnd,
    required this.price,
    required this.dateSlot,
    required this.consultantName,
    required this.imageUrl,
    required this.consultantId,
    required this.customerId,
  });
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool isLoadling = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHasBackIcon(size, context, 'BOOKING', () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 450,
              decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(38),
                    bottomRight: Radius.circular(38),
                  )),
              child: Container(
                margin: EdgeInsets.only(left: 10, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 35, top: 10),
                      child:
                          // Image.asset('assets/images/cute.jpg'),
                          Image(
                        image: NetworkImage(widget.imageUrl!),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              widget.consultantName!,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'roboto'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              'Love, Family, Education',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'roboto'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              'Giá: ' + widget.price.toString(),
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'roboto'),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                'Thời gian bắt đầu: ' + widget.timeStart!,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 22,
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                'Thời gian kết thúc: ' + widget.timeEnd!,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 22,
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                'Thời lượng : 30 minutes',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25,
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                'Ngày: ' +
                    DateFormat.yMd()
                        .format(DateTime.parse(widget.dateSlot!))
                        .toString(),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25,
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoadling = true;
                        });
                        bookingSlot(widget.slotId, widget.consultantId,
                            widget.customerId);
                        Future.delayed(
                          Duration(seconds: 3),
                          () {
                            setState(() {
                              isLoadling = false;
                            });
                          },
                        );
                      },
                      child: isLoadling
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'XÁC NHẬN',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
