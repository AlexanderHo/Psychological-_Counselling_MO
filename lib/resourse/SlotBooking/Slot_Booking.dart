import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/Slot_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/reponsitory/slot_.dart';
import 'package:astrology/resourse/Astrologer/AstrologerDetail.dart';
import 'package:astrology/resourse/Booking/booking.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class SlotBookingPage extends StatefulWidget {
  int consultantId;
  SlotBookingPage({required this.consultantId});

  @override
  State<SlotBookingPage> createState() => _SlotBookingPageState();
}

class _SlotBookingPageState extends State<SlotBookingPage> {
  DateTime? date = DateTime.now();
  DateFormat formatDate = DateFormat('yyyy-MM-dd');
  String _date = '';

  late Future<List<SlotModel>> slot;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      slot = fetchSlot(widget.consultantId, _date = formatDate.format(date!));
    });
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 31)),
    ).then((value) {
      setState(() {
        date = value!;
        slot = fetchSlot(widget.consultantId, _date = formatDate.format(date!));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHasBackIcon(size, context, 'Đặt lịch hẹn', () {
        AppRouter.push(AstroDetailPage(consulId: widget.consultantId));
      }),
      body: Column(
        children: [
          Container(
              color: Colors.blue.shade100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                            '${DateFormat.MMMM().format(date!)}',
                            style: TextStyle(
                                fontStyle: FontStyle.normal, fontSize: 18.0),
                          ),
                          Text(
                            '${date!.day}',
                            style: TextStyle(
                                fontStyle: FontStyle.normal, fontSize: 20.0),
                          ),
                          Text(
                            '${DateFormat.EEEE().format(date!)}',
                            style: TextStyle(
                                fontStyle: FontStyle.normal, fontSize: 20.0),
                          )
                        ],
                      ),
                    ),
                  )),
                  GestureDetector(
                    onTap: _showDatePicker,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.calendar_today, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 620,
              width: 500,
              child: FutureBuilder<List<SlotModel>>(
                future: slot,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong!!'),
                    );
                  } else if (snapshot.hasData) {
                    return SlotList(SlotModels: snapshot.data!);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          // Expanded(
          //     child: Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ElevatedButton(
          //           onPressed: () {},
          //           child: Text(
          //             'BOOKING',
          //             style:
          //                 TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //           ))
          //     ],
          //   ),
          // )),
        ],
      ),
    );
  }
}

class SlotList extends StatelessWidget {
  const SlotList({Key? key, required this.SlotModels}) : super(key: key);

  final List<SlotModel> SlotModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 2,
        //   // mainAxisSpacing:10.0,
        //   // crossAxisSpacing:5.0,
        //   childAspectRatio: 0.9,
        // ),
        itemCount: SlotModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPage(
                        slotId: SlotModels[index].id,
                        timeStart: SlotModels[index].timeStart,
                        timeEnd: SlotModels[index].timeEnd,
                        price: SlotModels[index].price ?? 0,
                        dateSlot: SlotModels[index].dateSlot,
                        consultantName: SlotModels[index].consultantName,
                        imageUrl: SlotModels[index].imageUrl,
                        consultantId: SlotModels[index].consultantId,
                        customerId: CurrentUser.getUserId()!),
                    // PlanetdetailPage(
                    //       id: planetModels[index].id,)
                  ),
                );
              },
              child: slotItem(
                item: SlotModels[index],
              ));
        });
  }
}

class slotItem extends StatelessWidget {
  SlotModel item;
  slotItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateFormat formatTime = DateFormat('HH:mm');
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.green.shade50,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 3, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    '${formatTime.format(_convertStringToDateTime(item.timeStart!)!)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    '-' +
                        '${formatTime.format(_convertStringToDateTime(item.timeEnd!)!)}',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'giá :' + item.price.toString(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? _convertStringToDateTime(String time) {
    DateTime? _dateTime;
    try {
      _dateTime = new DateFormat("hh:mm").parse(time);
    } catch (e) {}
    return _dateTime;
  }
}
