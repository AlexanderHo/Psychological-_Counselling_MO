import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/Components/bottom_bar.dart';
import 'package:astrology/model/RoomVideo_model.dart';
import 'package:astrology/model/Slot_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/reponsitory/room_.dart';
import 'package:astrology/reponsitory/slot_.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  int customerId = CurrentUser.getUserId() ?? 0;
  DateTime? date = DateTime.now();
  DateFormat formatDate = DateFormat('yyyy-MM-dd');
  String _date = '';

  late Future<List<SlotModel>> slot;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slot = fetchSlotApm(customerId, _date = formatDate.format(date!));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHome(size, context),
      body: Container(
        // constraints:
        //     BoxConstraints(minHeight: size.height, minWidth: size.width),
        // padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage('assets/background/anh-sao-bang.jpg'),
        //   fit: BoxFit.fitHeight,
        // )),
        color: Color(0xff17384e),
        child: Column(
          children: [
            Container(
                color: Colors.blue.shade50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(
                              '${date}'.split(' ')[0],
                              style: TextStyle(
                                  fontStyle: FontStyle.normal, fontSize: 15.0),
                            ),
                            CalendarDatePicker(
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 31)),
                                onDateChanged: (newDate) {
                                  setState(() {
                                    date = newDate;
                                    slot = fetchSlotApm(customerId,
                                        _date = formatDate.format(date!));
                                  });
                                })
                          ],
                        ),
                      ),
                    )),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 267,
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
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff031d2e),
        child: BottomBar(selected: "schedule"),
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
        itemCount: SlotModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
              child: slotItem(
                item: SlotModels[index],
              ));
        });
  }
}

class slotItem extends StatelessWidget {
  SlotModel item;
  slotItem({required this.item});
  RoomModel? rom;
  late Future<RoomModel> room;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateFormat formatTime = DateFormat('HH:mm');
    TextEditingController? reason = TextEditingController();
    final _reasonKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.green.shade50,
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
                    border: Border.all(color: Colors.white),
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl!),
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.consultantName!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Chủ đề',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${formatTime.format(_convertStringToDateTime(item.timeStart!)!)}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            '-' +
                                '${formatTime.format(_convertStringToDateTime(item.timeEnd!)!)}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red.shade300,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('Thông báo'),
                                          content: Text(
                                              'Bạn có chắc muốn hủy lịch hẹn của Slot này'),
                                          actions: <Widget>[
                                            Form(
                                              key: _reasonKey,
                                              child: TextFormField(
                                                controller: reason,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Nhập lý do hủy của bạn...'),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Vui lòng nhập lý do...';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 3),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        if (_reasonKey
                                                            .currentState!
                                                            .validate()) {
                                                          CancelBooking(
                                                              reason,
                                                              item.id,
                                                              DateFormat.yMd()
                                                                  .format(DateTime
                                                                      .parse(item
                                                                          .dateSlot!))
                                                                  .toString());
                                                          Navigator.pop(context,
                                                              'Xác nhận');
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Xác nhận')),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Hủy');
                                                      },
                                                      child: const Text('Hủy')),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 213, 57, 57))),
                              child: const Text(
                                "Hủy",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green.shade300,
                            ),
                            child: OutlinedButton(
                              onPressed: () {
                                room = fetchRoom(item.id, item.bookingId!);
                              },
                              child: Text(
                                'Tham gia',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
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
